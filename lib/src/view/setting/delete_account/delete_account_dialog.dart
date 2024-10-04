import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../component/error_dialog.dart';
import '../../../../theme/colors.dart';
import '../../../model/custom_error.dart';
import 'delete_account_provider.dart';

class DeleteAccountDialog extends ConsumerStatefulWidget {
  const DeleteAccountDialog({super.key});

  @override
  _DeleteAccountDialogState createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends ConsumerState<DeleteAccountDialog> {
  bool submitting = false;

  Future<void> _deleteAccount() async {
    await ref.read(deleteAccountProvider.notifier).deleteAccount();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      deleteAccountProvider,
      (previous, next) {
        next.whenOrNull(
          error: (e, st) {
            errorDialog(context, e as CustomError);
          },
          data: (_) {
            GoRouter.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account deleted successfully'),
              ),
            );
          },
        );
      },
    );

    return AlertDialog(
      title: const Text('계정 삭제'),
      content: const Text('정말로 계정을 삭제하시겠습니까? 나중에 취소할 수 없습니다.'),
      actions: [
        TextButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () => _deleteAccount(),
          style: TextButton.styleFrom(
            backgroundColor: AppColors.focusRedColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('삭제'),
        ),
      ],
    );
  }
}
