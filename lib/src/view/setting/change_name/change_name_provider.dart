import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:up_down/src/provider/auth_repository_provider.dart';

part 'change_name_provider.g.dart';

@riverpod
class ChangeName extends _$ChangeName {
  @override
  FutureOr<void> build() {}
  Future<void> changeName(String name) async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard<void>(
      () => ref.read(authRepositoryProvider).changeName(name),
    );
  }
}
