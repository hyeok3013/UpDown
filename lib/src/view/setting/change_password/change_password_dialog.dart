import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:up_down/src/view/setting/change_password/change_password_provider.dart';
import '../../../../component/error_dialog.dart';
import '../../../../component/form_fields.dart';
import '../../../model/custom_error.dart';
import '../setting_provider.dart';

class ChangePasswordDialog extends ConsumerStatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  _ProfileEditDialogState createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends ConsumerState<ChangePasswordDialog> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  void _submit() async {
    FocusScope.of(context).unfocus();
    setState(() => _autovalidateMode = AutovalidateMode.always);

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    final profileEdit = ref.read(changePasswordProvider.notifier);

    // 비밀번호 변경
    await profileEdit.changePassword(_passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final changePasswordState = ref.watch(changePasswordProvider);

    ref.listen<AsyncValue<void>>(
      changePasswordProvider,
      (previous, next) {
        next.whenOrNull(
          error: (e, st) {
            errorDialog(context, e as CustomError);
          },
          data: (_) {
            ref.invalidate(profileProvider);
            GoRouter.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Your Password has been updated'),
              ),
            );
          },
        );
      },
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AlertDialog(
        title: const Text('비밀번호 변경'),
        content: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              PasswordFormField(passwordController: _passwordController),
              ConfirmPasswordFormField(passwordController: _passwordController),
            ],
          ),
        ),
        actions: [
          Center(
              child: changePasswordState.maybeWhen(
            loading: () => const CircularProgressIndicator(),
            orElse: () => TextButton(
              onPressed: _submit,
              child: const Text('저장'),
            ),
          )),
        ],
      ),
    );
  }
}
