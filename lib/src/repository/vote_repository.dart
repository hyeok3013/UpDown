import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:up_down/src/model/vote.dart';
import 'package:up_down/util/helper/firebase_helper.dart';
import 'package:up_down/util/helper/handle_exception.dart';

class VoteRepository {
  /// 특정 방의 투표 데이터를 실시간으로 가져오기
  Stream<Vote> getVoteStream(String roomId) {
    try {
      return roomsCollection
          .doc(roomId)
          .collection('vote')
          .doc(roomId)
          .snapshots()
          .map((doc) {
        if (!doc.exists) {
          createVote(
            voteId: roomId,
            roomId: roomId,
            personName: 'Unknown',
          );
          return Vote(
            voteId: roomId,
            roomId: roomId,
            personName: 'Unknown',
            guiltyCount: 0,
            notGuiltyCount: 0,
            participants: {},
          );
        }
        return Vote.fromDoc(doc);
      });
    } catch (e) {
      throw handleException(e);
    }
  }

  /// 투표 초기 생성
  Future<void> createVote({
    required String voteId, // 투표의 고유 ID
    required String roomId, // 채팅방 ID (투표 대상의 사람과 연결)
    required String personName, // 투표 대상 (채팅방 제목 = 사람 이름)
    int? guiltyCount, // 잘못했다는 투표 수
    int? notGuiltyCount, // 잘못하지 않았다는 투표 수
    Map<String, bool>? participants, // Map to track user ID and their vote
  }) async {
    try {
      await roomsCollection.doc(roomId).collection('vote').doc(voteId).set({
        'voteId': voteId,
        'roomId': roomId,
        'personName': personName,
        'guiltyCount': guiltyCount ?? 0,
        'notGuiltyCount': notGuiltyCount ?? 0,
        'participants': participants ?? {},
      });
    } catch (e) {
      throw handleException(e);
    }
  }

  /// 투표 업데이트 (참여자 및 결과 업데이트)
  Future<void> updateVote({
    required String roomId,
    required String userId,
    required bool isGuilty,
  }) async {
    try {
      final voteDoc =
          roomsCollection.doc(roomId).collection('vote').doc(roomId);

      final voteSnapshot = await voteDoc.get();
      final voteData = Vote.fromDoc(voteSnapshot);

      // 이미 투표한 사용자 중복 방지
      if (voteData.participants.containsKey(userId)) {
        return; // 이미 투표한 경우, 업데이트 하지 않음
      }

      final updatedGuiltyCount =
          isGuilty ? voteData.guiltyCount + 1 : voteData.guiltyCount;
      final updatedNotGuiltyCount =
          !isGuilty ? voteData.notGuiltyCount + 1 : voteData.notGuiltyCount;

      // Firestore에 업데이트
      await voteDoc.update({
        'guiltyCount': updatedGuiltyCount,
        'notGuiltyCount': updatedNotGuiltyCount,
        'participants': {
          ...voteData.participants,
          userId: isGuilty, // 사용자의 투표 결과를 저장 (true: guilty, false: not guilty)
        },
      });
    } catch (e) {
      throw handleException(e);
    }
  }
}
