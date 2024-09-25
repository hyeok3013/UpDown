import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:up_down/component/error_dialog.dart';
import 'package:up_down/src/model/custom_error.dart';
import 'package:up_down/src/provider/auth_repository_provider.dart';
import 'package:up_down/src/view/home/home_provider.dart';
import 'package:up_down/util/helper/firebase_helper.dart';
import 'package:up_down/util/router/route_names.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = fbAuth.currentUser!.uid;
    final profileState = ref.watch(profileProvider(uid));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await ref.read(authRepositoryProvider).signout();
              } on CustomError catch (e) {
                if (!context.mounted) return;
                errorDialog(context, e);
              }
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              ref.invalidate(profileProvider);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: profileState.when(
        skipLoadingOnRefresh: false,
        data: (appUser) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome ${appUser.name}',
                  style: const TextStyle(fontSize: 24.0),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Your Profile',
                  style: TextStyle(fontSize: 24.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'email: ${appUser.email}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'id: ${appUser.id}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 40),
                OutlinedButton(
                  onPressed: () {
                    GoRouter.of(context).goNamed(RouteNames.changePassword);
                  },
                  child: const Text(
                    'Change Password',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          );
        },
        error: (e, _) {
          final error = e as CustomError;

          return Center(
            child: Text(
              'code: ${error.code}\nplugin: ${error.plugin}\nmessage: ${error.message}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
