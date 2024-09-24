import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:up_down/src/repository/auth_repository.dart';
import 'package:up_down/util/helper/firebase_helper.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository();
}

@riverpod
Stream<User?> authStateStream(AuthStateStreamRef ref) {
  return fbAuth.authStateChanges();
}
