import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SigninView extends ConsumerStatefulWidget {
  const SigninView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SigninViewState();
}

class _SigninViewState extends ConsumerState<SigninView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Sign In'),
      ),
    );
  }
}
