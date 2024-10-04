import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:up_down/util/helper/handle_exception.dart';

class ImageRepository {
  final FirebaseStorage _storage;

  ImageRepository(this._storage);

  Future<String?> uploadImage(XFile image) async {
    final String fileName = image.name;
    final Reference storageRef = _storage.ref().child('chat_images/$fileName');

    try {
      await storageRef.putFile(File(image.path)); // 파일 업로드
      final String downloadUrl = await storageRef.getDownloadURL(); // URL 가져오기
      return downloadUrl;
    } catch (e) {
      throw handleException(e); // 에러 처리
    }
  }
}
