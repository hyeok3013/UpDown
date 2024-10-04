import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../component/error_dialog.dart';
import '../../../../component/form_fields.dart';
import '../../../../util/helper/firebase_helper.dart';
import '../../../model/custom_error.dart';
import '../setting_provider.dart';
import 'change_name_provider.dart';

class ChangeNameDialog extends ConsumerStatefulWidget {
  const ChangeNameDialog({super.key});

  @override
  _ProfileEditDialogState createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends ConsumerState<ChangeNameDialog> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    // 초기 상태 설정
    final uid = fbAuth.currentUser!.uid;
    final profileState = ref.read(profileProvider(uid));
    profileState.whenData((profile) {
      _nameController.text = profile.name;
    });
  }

  void _submit() async {
    FocusScope.of(context).unfocus();
    setState(() => _autovalidateMode = AutovalidateMode.always);

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    final profileEdit = ref.read(changeNameProvider.notifier);

    // 사용자 이름 변경
    await profileEdit.changeName(_nameController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final changeNameState = ref.watch(changeNameProvider);

    ref.listen<AsyncValue<void>>(
      changeNameProvider,
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
                content: Text('Your Name has been updated'),
              ),
            );
          },
        );
      },
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AlertDialog(
        title: const Text('닉네임 변경'),
        content: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              NameFormField(nameController: _nameController),
            ],
          ),
        ),
        actions: [
          Center(
              child: changeNameState.maybeWhen(
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
