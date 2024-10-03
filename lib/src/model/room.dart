// lib/src/model/room.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  factory Room({
    required String roomId,
    required String roomName,
    required String personName,
    required String imageUrl,
    required DateTime roomStartDate,
    required DateTime roomEndDate,
    @Default([]) List<String> participants, // 참가자 리스트
    @Default(0) int participantCount, // 참가자 수를 따로 저장
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  factory Room.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Room(
      roomId: data['roomId'] ?? doc.id,
      roomName: data['roomName'] ?? 'Untitled',
      personName: data['personName'] ?? 'Unknown',
      imageUrl: data['imageUrl'] ?? '',
      roomStartDate: (data['roomStartDate'] as Timestamp).toDate(),
      roomEndDate: (data['roomEndDate'] as Timestamp).toDate(),
      participants: List<String>.from(data['participants'] ?? []),
      participantCount: data['participantCount'] ?? 0,
    );
  }
}
