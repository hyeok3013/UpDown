import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:up_down/src/repository/image_repository.dart';

part 'image_repository_provider.g.dart';

@riverpod
ImageRepository imageRepository(ImageRepositoryRef ref) {
  return ImageRepository(FirebaseStorage.instance); // Firebase Storage 인스턴스
}
