import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vote.freezed.dart';

@freezed
class Vote with _$Vote {
  const factory Vote({
    required String voteId, // 투표의 고유 ID
    required String roomId, // 채팅방 ID (투표 대상의 사람과 연결)
    required String personName, // 투표 대상 (채팅방 제목 = 사람 이름)
    required int guiltyCount, // 잘못했다는 투표 수
    required int notGuiltyCount, // 잘못하지 않았다는 투표 수
    required List<String> participants, // 투표에 참여한 유저 ID 목록
  }) = _Vote;

  factory Vote.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Vote(
      voteId: doc.id,
      roomId: data['roomId'],
      personName: data['personName'],
      guiltyCount: data['guiltyCount'],
      notGuiltyCount: data['notGuiltyCount'],
      participants: List<String>.from(data['participants']),
    );
  }
}
