import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:up_down/component/buttons.dart';
import 'package:up_down/component/error_dialog.dart';
import 'package:up_down/component/form_fields.dart';
import 'package:up_down/src/model/custom_error.dart';
import 'package:up_down/src/view/auth/reset_password/reset_password_provider.dart';
import 'package:up_down/util/router/route_names.dart';

class ResetPasswordView extends ConsumerStatefulWidget {
  const ResetPasswordView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordViewState();
}

class _ResetPasswordViewState extends ConsumerState<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _autovalidateMode = AutovalidateMode.always);

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    ref.read(resetPasswordProvider.notifier).resetPassword(
          email: _emailController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      resetPasswordProvider,
      (previous, next) {
        next.whenOrNull(
          error: (e, st) => errorDialog(
            context,
            e as CustomError,
          ),
        );
      },
    );

    final resetPwdState = ref.watch(resetPasswordProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: ListView(
                shrinkWrap: true,
                reverse: true,
                children: [
                  const FlutterLogo(size: 150),
                  const SizedBox(height: 20.0),
                  EmailFormField(emailController: _emailController),
                  const SizedBox(height: 20.0),
                  CustomFilledButton(
                    onPressed: resetPwdState.maybeWhen(
                      loading: () => null,
                      orElse: () => _submit,
                    ),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    child: Text(
                      resetPwdState.maybeWhen(
                        loading: () => 'Submitting...',
                        orElse: () => 'Reset Password',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Remember password? '),
                      CustomTextButton(
                        onPressed: resetPwdState.maybeWhen(
                          loading: () => null,
                          orElse: () =>
                              () => context.goNamed(RouteNames.signin),
                        ),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        child: const Text('Sign In'),
                      ),
                    ],
                  ),
                ].reversed.toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
