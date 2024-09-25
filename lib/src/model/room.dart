import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'room.freezed.dart';

@freezed
class Room with _$Room {
  const factory Room({
    required String roomId,
    required String roomName,
    required String personName,
    required String imageUrl,
    required DateTime roomStartDate,
    required DateTime roomEndDate,
  }) = _Room;

  factory Room.fromDoc(DocumentSnapshot roomDoc) {
    final roomData = roomDoc.data() as Map<String, dynamic>;
    return Room(
      roomId: roomData['roomId'] ?? '',
      roomName: roomData['roomName'] ?? '',
      personName: roomData['personName'] ?? '',
      imageUrl: roomData['imageUrl'] ?? '',
      roomStartDate: (roomData['roomStartDate'] as Timestamp)
          .toDate(), // Timestamp를 DateTime으로 변환
      roomEndDate: (roomData['roomEndDate'] as Timestamp)
          .toDate(), // Timestamp를 DateTime으로 변환
    );
  }
}
