import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:paperless/exports.dart'
    show AuthCubit, Debouncer, ServerStatus, ThemeExtension;
import 'package:shadcn_ui/shadcn_ui.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  ServerStatus _serverStatus = ServerStatus.initial;
  bool _isPasswordVisible = false;
  late final _formKey = GlobalKey<ShadFormState>();
  late final _debouncer = Debouncer(const Duration(milliseconds: 500));

  ShadInputFormField _createInput({
    required String id,
    List<String>? autofillHints,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    Widget? prefix,
    Widget? suffix,
    String? Function(String)? validator,
    void Function(String)? onChanged,
    bool obscureText = false,
    TextEditingController? controller,
    bool autofocus = false,
  }) {
    return ShadInputFormField(
      id: id,
      controller: controller,
      placeholder: Text('auth.$id.placeholder').tr(),
      autofillHints: autofillHints,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      prefix: prefix == null
          ? null
          : Padding(
              padding: const EdgeInsets.all(4),
              child: prefix,
            ),
      suffix: suffix,
      decoration: const ShadDecoration(
        secondaryBorder: ShadBorder.none,
        secondaryFocusedBorder: ShadBorder.none,
      ),
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      autofocus: autofocus,
    );
  }

  Future<void> _next() async {
    if (_serverStatus.isUnreachable) {
      ShadToaster.maybeOf(context)?.show(
        ShadToast.destructive(
          title: const Text('auth.server.error.unreachable.title').tr(),
          description: const Text('auth.server.error.unreachable.message').tr(),
          padding: const EdgeInsets.all(16),
        ),
      );
      return;
    }
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final data = Map<String, dynamic>.from(_formKey.currentState!.value);
    }
  }

  Future<void> _validateServer(String serverUrl) async {
    _debouncer(() async {
      void recheck(AuthCubit authCubit, [ServerStatus? status]) {
        _serverStatus = status ?? authCubit.getServerStatus(serverUrl);
        setState(() {});
      }

      final isUrlValid = _validateServerInput(serverUrl);
      if (isUrlValid != null) return;
      final authCubit = context.read<AuthCubit>();
      recheck(authCubit, ServerStatus.checking);
      await authCubit.validateServer(serverUrl);
      recheck(authCubit);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((AuthCubit c) => c.state.stage.isLoading);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ShadForm(
        key: _formKey,
        child: AutofillGroup(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'auth.title',
                    style: context.textTheme.h2,
                    textAlign: TextAlign.center,
                  ).tr(),
                  const Gap(36),
                  _createInput(
                    id: 'server',
                    autofillHints: [AutofillHints.url],
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.next,
                    prefix: const ShadImage.square(size: 16, LucideIcons.link),
                    validator: _validateServerInput,
                    onChanged: _validateServer,
                    suffix: _createServerStatusSuffix(_serverStatus),
                    autofocus: true,
                  ),
                  AnimatedSize(
                    alignment: Alignment.topCenter,
                    duration: kThemeAnimationDuration,
                    child: SizedBox(
                      height: !_serverStatus.isReachable ? 0 : null,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Gap(16),
                          _createInput(
                            id: 'username',
                            textInputAction: TextInputAction.next,
                            prefix: const ShadImage.square(
                              size: 16,
                              LucideIcons.user,
                            ),
                            validator: (p0) {
                              if (p0.isEmpty) {
                                return 'auth.username.error.required'.tr();
                              }
                              return null;
                            },
                          ),
                          const Gap(16),
                          _createInput(
                            id: 'password',
                            autofillHints: [AutofillHints.password],
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !_isPasswordVisible,
                            textInputAction: TextInputAction.done,
                            prefix: const ShadImage.square(
                              size: 16,
                              LucideIcons.lock,
                            ),
                            suffix: _buildVisibilityController(),
                            validator: (p0) {
                              if (p0.isEmpty) {
                                return 'auth.password.error.required'.tr();
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(36),
                  ShadButton(
                    onPressed: _next,
                    child: isLoading
                        ? const SizedBox.square(
                            dimension: 24,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            ),
                          )
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

  ShadButton _buildVisibilityController() {
    return ShadButton(
      width: 24,
      height: 24,
      padding: EdgeInsets.zero,
      decoration: const ShadDecoration(
        secondaryBorder: ShadBorder.none,
        secondaryFocusedBorder: ShadBorder.none,
      ),
      icon: ShadImage.square(
        size: 16,
        _isPasswordVisible ? LucideIcons.eye : LucideIcons.eyeOff,
      ),
      onPressed: () {
        setState(() {
          _isPasswordVisible = !_isPasswordVisible;
        });
      },
    );
  }
}

String? _validateServerInput(String p0) {
  if (p0.isEmpty) {
    return 'auth.server.error.required'.tr();
  }

  if (p0.isNotEmpty) {
    final uri = Uri.tryParse(p0);
    if (uri == null || uri.scheme.isEmpty) {
      return 'auth.server.error.invalid'.tr();
    }
  }

  return null;
}

Widget? _createServerStatusSuffix(ServerStatus serverStatus) {
  return switch (serverStatus) {
    ServerStatus.initial => null,
    ServerStatus.checking => const SizedBox.square(
        dimension: 16,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      ),
    _ => Padding(
        padding: const EdgeInsets.all(4),
        child: ShadImage.square(
          size: 16,
          serverStatus.isReachable ? LucideIcons.check : LucideIcons.x,
          color: serverStatus.isReachable ? Colors.green : Colors.red,
        ),
      ),
  };
}
