import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:up_down/src/model/message.dart';
import 'package:up_down/src/model/vote.dart';
import 'package:up_down/src/provider/auth_repository_provider.dart';
import 'package:up_down/src/provider/message_repository_provider.dart';
import 'package:up_down/src/provider/vote_repository_provider.dart';
import 'package:up_down/src/view/chat/vote/vote_view_state.dart';
import 'package:up_down/util/helper/firebase_helper.dart';

part 'vote_provider.g.dart';

@riverpod
class Judgment extends _$Judgment {
  @override
  FutureOr<VoteViewState> build({required String roomId}) async {
    // 메시지와 투표 데이터를 동시에 가져옴
    final messagesFuture =
        ref.read(messageRepositoryProvider).getMessages(roomId);

    // 투표 데이터 확인 및 없으면 기본 투표 데이터 생성
    final voteFuture = await ref.read(voteRepositoryProvider).getVote(roomId);
    late Vote vote; // 나중에 초기화할 수 있도록 'late' 키워드 사용

    if (voteFuture == null) {
      await ref.read(voteRepositoryProvider).createVote(
            voteId: roomId,
            roomId: roomId,
            personName: 'kim',
          );
    } else {
      vote = voteFuture; // 투표 데이터가 있으면 그 값을 사용
    }

    // 메시지 데이터를 가져옴
    final messages = await messagesFuture;

    // VoteViewState로 초기 상태 설정
    return VoteViewState(messages: messages, vote: vote);
  }
  //
  // @override
  // FutureOr<VoteViewState> build({required String roomId}) async {
  //   // 메시지와 투표 데이터를 동시에 가져옴
  //   final messagesFuture =
  //   ref.read(messageRepositoryProvider).getMessages(roomId);
  //   final voteFuture = ref.read(voteRepositoryProvider).getVote(roomId);
  //
  //   // 병렬로 두 작업을 처리
  //   final results = await Future.wait([messagesFuture, voteFuture]);
  //
  //   final messages = results[0] as List<Message>;
  //   final vote = results[1] as Vote;
  //
  //   // VoteViewState로 초기 상태 설정
  //   return VoteViewState(messages: messages, vote: vote);
  // }

  Future<void> sendMessage({
    required String roomId,
    String? userId,
    required String message,
    Timestamp? sentAt,
  }) async {
    // state = const AsyncLoading<List<Message>>();
    state = state.whenData((currentMessages) => currentMessages);

    state = await AsyncValue.guard(() async {
      ref.read(messageRepositoryProvider).sendMessage(
            roomId: roomId,
            userId: fbAuth.currentUser!.uid,
            message: message,
            sentAt: Timestamp.now(),
          );
      final updatedMessages =
          await ref.read(messageRepositoryProvider).getMessages(roomId);
      return state.value!.copyWith(messages: updatedMessages);
    });
  }

  /// 투표 업데이트
  Future<void> castVote({
    required String roomId,
    String? userId,
    required bool isGuilty,
  }) async {
    state = state.whenData((currentState) => currentState);

    state = await AsyncValue.guard(() async {
      await ref.read(voteRepositoryProvider).updateVote(
            roomId: roomId,
            userId: fbAuth.currentUser!.uid,
            isGuilty: isGuilty,
          );

      final updatedVote =
          await ref.read(voteRepositoryProvider).getVote(roomId);
      return state.value!.copyWith(vote: updatedVote);
    });
  }
}
