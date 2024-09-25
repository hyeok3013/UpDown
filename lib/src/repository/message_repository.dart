import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:up_down/src/model/message.dart';
import 'package:up_down/util/helper/firebase_helper.dart';
import 'package:up_down/util/helper/handle_exception.dart';

class MessageRepository {
  /// 특정 방의 메시지들을 가져오기
  Future<List<Message>> getMessages(String roomId) async {
    try {
      final messageCol = await roomsCollection
          .doc(roomId)
          .collection('messages_test')
          .orderBy('sentAt', descending: true)
          .get();

      return messageCol.docs
          .map((doc) => Message.fromDoc(doc)) // 문서를 Message 객체로 변환
          .toList();
    } catch (e) {
      throw handleException(e);
    }
  }

  /// 새 메시지 추가
  Future<void> sendMessage({
    required String roomId,
    required String userId,
    required String message,
    required Timestamp sentAt,
  }) async {
    try {
      await roomsCollection.doc(roomId).collection('messages_test').add({
        'userId': userId,
        'message': message,
        'sentAt': sentAt,
      });
    } catch (e) {
      throw handleException(e);
    }
  }
}
