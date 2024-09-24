import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordView extends ConsumerStatefulWidget {
  const ResetPasswordView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordViewState();
}

class _ResetPasswordViewState extends ConsumerState<ResetPasswordView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Reset Password'),
      ),
    );
  }
}
