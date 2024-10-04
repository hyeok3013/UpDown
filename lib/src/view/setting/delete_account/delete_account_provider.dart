import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../provider/auth_repository_provider.dart';

part 'delete_account_provider.g.dart';

@riverpod
class DeleteAccount extends _$DeleteAccount {
  @override
  FutureOr<void> build() {}

  Future<void> deleteAccount() async {
    state = const AsyncLoading<void>();

    state = await AsyncValue.guard<void>(
      () => ref.read(authRepositoryProvider).deleteAccount(),
    );
  }
}
