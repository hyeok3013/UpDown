import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:up_down/src/model/app_user.dart';
import 'package:up_down/src/provider/profile_repository_provider.dart';

part 'setting_provider.g.dart';

@riverpod
FutureOr<AppUser> profile(ProfileRef ref, String uid) {
  return ref.watch(profileRepositoryProvider).getProfile(uid: uid);
}
