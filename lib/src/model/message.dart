import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'message.freezed.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String userId,
    required String name,
    required String message,
    required Timestamp sentAt,
    required bool isMyTurn,
  }) = _Message;

  factory Message.fromDoc(DocumentSnapshot messageDoc) {
    final messageDate = messageDoc.data() as Map<String, dynamic>;
    return Message(
      userId: messageDate['userId'],
      name: messageDate['name'],
      message: messageDate['message'],
      sentAt: messageDate['sentAt'],
      isMyTurn: messageDate['isMyTurn'],
    );
  }
}
