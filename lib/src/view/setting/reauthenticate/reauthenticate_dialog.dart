import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:up_down/component/error_dialog.dart';
import 'package:up_down/component/form_fields.dart';
import 'package:up_down/src/model/custom_error.dart';
import 'package:up_down/src/provider/auth_repository_provider.dart';

import '../../../../util/helper/firebase_helper.dart';
import '../setting_provider.dart';

class ReauthenticateDialog extends ConsumerStatefulWidget {
  const ReauthenticateDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReauthenticateDialogState();
}

class _ReauthenticateDialogState extends ConsumerState<ReauthenticateDialog> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool submitting = false;

  @override
  void initState() {
    super.initState();
    // 초기 상태 설정
    final uid = fbAuth.currentUser!.uid;
    final profileState = ref.read(profileProvider(uid));
    profileState.whenData((profile) {
      _emailController.text = profile.email;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    setState(() {
      submitting = true;
    });

    try {
      final navigator = Navigator.of(context);

      await ref.read(authRepositoryProvider).reauthenticateWithCredential(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );

      setState(() {
        submitting = false;
      });

      navigator.pop('success');
    } on CustomError catch (e) {
      setState(() {
        submitting = false;
      });
      if (!mounted) return;
      errorDialog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AlertDialog(
        title: const Text('본인인증'),
        content: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              EmailFormField(
                emailController: _emailController,
                enabled: false,
              ),
              PasswordFormField(passwordController: _passwordController),
            ],
          ),
        ),
        actions: [
          Center(
            child: submitting
                ? const CircularProgressIndicator()
                : TextButton(
                    onPressed: _submit,
                    child: const Text('확인'),
                  ),
          ),
        ],
      ),
    );
  }
}
