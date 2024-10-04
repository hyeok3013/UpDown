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
    required Map<String, bool>
        participants, // 유저 ID와 투표 결과를 담는 Map (true: guilty, false: not guilty)
  }) = _Vote;

  factory Vote.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // participants 필드가 List인지 Map인지 확인하고 처리
    final participantsData = data['participants'];
    Map<String, bool> participants = {};

    if (participantsData is List) {
      print("Participants is List: $participantsData"); // 디버깅 로그 추가
      // participants가 List<String>인 경우, 이를 Map<String, bool>로 변환
      for (String userId in participantsData) {
        participants[userId] = false; // 임시로 false 값을 할당
      }
    } else if (participantsData is Map) {
      participants = Map<String, bool>.from(participantsData);
    }

    return Vote(
      voteId: doc.id,
      roomId: data['roomId'],
      personName: data['personName'],
      guiltyCount: data['guiltyCount'],
      notGuiltyCount: data['notGuiltyCount'],
      participants: participants,
    );
  }
}
