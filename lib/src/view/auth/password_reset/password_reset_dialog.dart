import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:up_down/src/view/auth/password_reset/password_reset_provider.dart';

import '../../../model/custom_error.dart';
import '../../../../component/error_dialog.dart';
import '../../../../component/form_fields.dart';

class PasswordResetDialog extends ConsumerStatefulWidget {
  const PasswordResetDialog({super.key});

  @override
  _PasswordResetDialogState createState() => _PasswordResetDialogState();
}

class _PasswordResetDialogState extends ConsumerState<PasswordResetDialog> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _emailController = TextEditingController();

  Future<void> _sendPasswordResetEmail() async {
    FocusScope.of(context).unfocus();
    setState(() => _autovalidateMode = AutovalidateMode.always);

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    ref.read(passwordResetProvider.notifier).resetPassword(
          email: _emailController.text.trim(),
        );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      passwordResetProvider,
      (previous, next) {
        next.whenOrNull(
          error: (e, st) => errorDialog(context, e as CustomError),
          data: (_) {
            GoRouter.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password reset email has been sent'),
              ),
            );
          },
        );
      },
    );

    final resetPwdState = ref.watch(passwordResetProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AlertDialog(
        title: const Text('Password Reset'),
        content: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              EmailFormField(emailController: _emailController),
            ],
          ),
        ),
        actions: [
          Center(
              child: resetPwdState.maybeWhen(
            loading: () => const CircularProgressIndicator(),
            orElse: () => TextButton(
              onPressed: _sendPasswordResetEmail,
              child: const Text('Send'),
            ),
          )),
        ],
      ),
    );
  }
}
