import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:up_down/src/repository/profile_repository.dart';

part 'profile_repository_provider.g.dart';

@riverpod
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  return ProfileRepository();
}
