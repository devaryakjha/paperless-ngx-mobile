import 'package:flutter/widgets.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    // split the process into server validation and then user login
    return const Placeholder();
  }
}



// const _decoration = ShadDecoration(
//   secondaryBorder: ShadBorder.none,
//   secondaryFocusedBorder: ShadBorder.none,
// );

// class AuthPage extends StatefulWidget {
//   const AuthPage({super.key});

//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   late final _formKey = GlobalKey<ShadFormState>();
//   bool obscure = true;

//   void _onSubmit() {
//     if (_formKey.currentState?.saveAndValidate() ?? false) {
//       // final data = Map<String, dynamic>.from(_formKey.currentState!.value);
//       // context.read<AuthCubit>().signIn(AuthFormData.fromJson(data));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final loading = context.select((AuthCubit c) => c.state.stage.isLoading);
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: const Text('app_title').tr(),
//         actions: const [
//           PaperlessLogo(),
//           Gap(16),
//         ],
//       ),
//       body: ShadForm(
//         key: _formKey,
//         enabled: !loading,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: AutofillGroup(
//             child: Center(
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(maxHeight: 400),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'auth.title',
//                         style: context.textTheme.h2,
//                         textAlign: TextAlign.center,
//                       ).tr(),
//                       const Gap(36),
//                       ShadInputFormField(
//                         id: 'server_url',
//                         autofocus: true,
//                         placeholder: const Text('auth.server.placeholder').tr(),
//                         autofillHints: const [AutofillHints.url],
//                         keyboardType: TextInputType.url,
//                         textInputAction: TextInputAction.next,
//                         prefix: const Padding(
//                           padding: EdgeInsets.all(4),
//                           child: ShadImage.square(size: 16, LucideIcons.link),
//                         ),
//                         decoration: _decoration,
//                         validator: (p0) {
//                           if (p0.isEmpty) {
//                             return 'auth.server.error.required'.tr();
//                           }

//                           if (p0.isNotEmpty) {
//                             final uri = Uri.tryParse(p0);
//                             if (uri == null || uri.scheme.isEmpty) {
//                               return 'auth.server.error.invalid'.tr();
//                             }
//                           }
//                           return null;
//                         },
//                       ),
//                       const Gap(16),
//                       ShadInputFormField(
//                         id: 'username',
//                         placeholder:
//                             const Text('auth.username.placeholder').tr(),
//                         autofillHints: const [AutofillHints.username],
//                         keyboardType: TextInputType.name,
//                         textInputAction: TextInputAction.next,
//                         prefix: const Padding(
//                           padding: EdgeInsets.all(4),
//                           child: ShadImage.square(size: 16, LucideIcons.user),
//                         ),
//                         decoration: _decoration,
//                         validator: (p0) {
//                           if (p0.isEmpty) {
//                             return 'auth.username.error.required'.tr();
//                           }
//                           return null;
//                         },
//                       ),
//                       const Gap(16),
//                       ShadInputFormField(
//                         id: 'password',
//                         placeholder:
//                             const Text('auth.password.placeholder').tr(),
//                         autofillHints: const [AutofillHints.password],
//                         keyboardType: TextInputType.visiblePassword,
//                         obscureText: obscure,
//                         textInputAction: TextInputAction.done,
//                         onSubmitted: (_) => _onSubmit(),
//                         prefix: const Padding(
//                           padding: EdgeInsets.all(4),
//                           child: ShadImage.square(size: 16, LucideIcons.lock),
//                         ),
//                         decoration: _decoration,
//                         suffix: ShadButton(
//                           width: 24,
//                           height: 24,
//                           padding: EdgeInsets.zero,
//                           decoration: const ShadDecoration(
//                             secondaryBorder: ShadBorder.none,
//                             secondaryFocusedBorder: ShadBorder.none,
//                           ),
//                           icon: ShadImage.square(
//                             size: 16,
//                             obscure ? LucideIcons.eyeOff : LucideIcons.eye,
//                           ),
//                           onPressed: () {
//                             setState(() => obscure = !obscure);
//                           },
//                         ),
//                         validator: (p0) {
//                           if (p0.isEmpty) {
//                             return 'auth.password.error.required'.tr();
//                           }
//                           return null;
//                         },
//                       ),
//                       const Gap(36),
//                       ShadButton(
//                         onPressed: _onSubmit,
//                         child: !loading
//                             ? const Text('auth.action.sign_in').tr()
//                             : const SizedBox.square(
//                                 dimension: 24,
//                                 child: CircularProgressIndicator(
//                                   color: Colors.black,
//                                   strokeWidth: 2,
//                                 ),
//                               ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
