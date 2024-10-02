import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:paperless/exports.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const _noDecoration = ShadDecoration(
  secondaryBorder: ShadBorder.none,
  secondaryFocusedBorder: ShadBorder.none,
);

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool hidePassword = true;
  late final _formkey = GlobalKey<ShadFormState>();
  late final _serverController = TextEditingController();

  void _next([_]) {
    final cubit = context.read<AuthCubit>();
    final authStatus = cubit.state.status;
    final isServerValid = authStatus == AuthStatus.serverValid;
    if (!isServerValid) {
      _triggerServerValidation(cubit);
    } else {
      if (_formkey.currentState?.saveAndValidate() ?? false) {
        final payload = _formkey.currentState?.value ?? {};
        cubit.signIn(Map<String, String>.from(payload));
      }
    }
  }

  Future<void> _triggerServerValidation(AuthCubit cubit) async {
    await cubit.checkServer(
      _serverController.text,
      () {
        ShadToaster.maybeOf(context)?.show(
          ShadToast.destructive(
            title: const Text('auth.error.server_unreachable.title').tr(),
            description:
                const Text('auth.error.server_unreachable.description').tr(),
            // type: ShadToastType.error,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authStatus = context.select((AuthCubit cubit) => cubit.state.status);
    final isServerValid = authStatus.serverValidated;
    final loading = authStatus.showLoading;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ShadForm(
        enabled: !loading,
        key: _formkey,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 400),
            child: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'auth.title',
                    style: context.textTheme.h2,
                    textAlign: TextAlign.center,
                  ).tr(),
                  const Gap(36),
                  InputField(
                    'server',
                    icon: LucideIcons.server,
                    textInputAction: isServerValid
                        ? TextInputAction.next
                        : TextInputAction.done,
                    onSubmitted: isServerValid ? null : _next,
                    suffixIcon: isServerValid ? LucideIcons.check : null,
                    suffixIconColor: Colors.green,
                    controller: _serverController,
                    onChanged: (value) {
                      if (isServerValid) {
                        context.read<AuthCubit>().resetStatus();
                      }
                    },
                    autofocus: true,
                  ),
                  const Gap(16),
                  AnimatedSize(
                    duration: kThemeAnimationDuration,
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: isServerValid ? null : 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const InputField('username', icon: LucideIcons.user),
                          const Gap(16),
                          InputField(
                            'password',
                            obscureText: hidePassword,
                            onSuffixPressed: () =>
                                setState(() => hidePassword = !hidePassword),
                            icon: LucideIcons.lock,
                            suffix: ShadImage.square(
                              size: 16,
                              hidePassword
                                  ? LucideIcons.eye
                                  : LucideIcons.eyeOff,
                            ),
                            textInputAction: TextInputAction.done,
                            onSubmitted: _next,
                          ),
                          const Gap(24),
                        ],
                      ),
                    ),
                  ),
                  ShadButton(
                    onPressed: loading ? null : _next,
                    child: loading
                        ? SizedBox.square(
                            dimension: 16,
                            child: CircularProgressIndicator(
                              strokeCap: StrokeCap.round,
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(
                                context.primaryButtonTheme.foregroundColor,
                              ),
                            ),
                          )
                        : !isServerValid
                            ? const Text('auth.action.validate').tr()
                            : const Text('auth.action.sign_in').tr(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField(
    this.id, {
    required this.icon,
    this.suffix,
    this.suffixIcon,
    this.suffixIconColor,
    this.onSuffixPressed,
    super.key,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.autofocus = false,
    this.enabled = true,
  });

  final String id;
  final IconData icon;
  final Widget? suffix;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final VoidCallback? onSuffixPressed;
  final bool obscureText;
  final bool autofocus;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ShadInputFormField(
      enabled: enabled,
      id: id,
      placeholder: Text('auth.$id.placeholder').tr(),
      validator: (value) {
        if (value.isEmpty) {
          return 'auth.$id.error.required'.tr();
        }
        return null;
      },
      autofocus: autofocus,
      textInputAction: textInputAction,
      controller: controller,
      prefix: Padding(
        padding: const EdgeInsets.all(4),
        child: ShadImage.square(icon, size: 16),
      ),
      obscureText: obscureText,
      decoration: _noDecoration,
      suffix: suffixIcon != null
          ? ShadImage.square(suffixIcon!, size: 16, color: suffixIconColor)
          : suffix != null
              ? ShadButton(
                  width: 24,
                  height: 24,
                  padding: EdgeInsets.zero,
                  decoration: _noDecoration,
                  icon: suffix,
                  onPressed: onSuffixPressed,
                )
              : null,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
    );
  }
}
