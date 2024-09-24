import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Sign Up'),
      ),
    );
  }
}
