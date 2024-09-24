import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyEmailView extends ConsumerStatefulWidget {
  const VerifyEmailView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerifyEmailViewState();
}

class _VerifyEmailViewState extends ConsumerState<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Verify Email'),
      ),
    );
  }
}
