import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReauthenticateView extends ConsumerStatefulWidget {
  const ReauthenticateView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReauthenticateViewState();
}

class _ReauthenticateViewState extends ConsumerState<ReauthenticateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reauthenticate'),
      ),
      body: const Center(
        child: Text('Reauthenticate'),
      ),
    );
  }
}
