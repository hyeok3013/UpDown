import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:up_down/src/provider/auth_repository_provider.dart';

part 'password_reset_provider.g.dart';

@riverpod
class PasswordReset extends _$PasswordReset {
  @override
  FutureOr<void> build() {}

  Future<void> resetPassword({required String email}) async {
    state = const AsyncLoading<void>();

    state = await AsyncValue.guard<void>(
      () => ref.read(authRepositoryProvider).sendPasswordResetEmail(email),
    );
  }
}
