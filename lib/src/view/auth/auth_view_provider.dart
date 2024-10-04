import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:up_down/src/provider/auth_repository_provider.dart';

part 'auth_view_provider.g.dart';

@riverpod
class SignIn extends _$SignIn {
  @override
  FutureOr<void> build() {}

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading<void>();

    state = await AsyncValue.guard<void>(
      () => ref
          .read(authRepositoryProvider)
          .signInWithEmail(email: email, password: password),
    );
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading<void>();

    state = await AsyncValue.guard<void>(
      () => ref.read(authRepositoryProvider).signInWithGoogle(),
    );
  }

  signInWithFacebook() {}
}
