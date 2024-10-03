// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:up_down/src/model/vote.dart';
// import 'package:up_down/src/provider/message_repository_provider.dart';
// import 'package:up_down/src/provider/vote_repository_provider.dart';
// import 'package:up_down/src/view/chat/vote/vote_view_state.dart';
// import 'package:up_down/src/view/result/result_view_model.dart';
// import 'package:up_down/util/helper/firebase_helper.dart';
//
// part 'vote_provider.g.dart';
//
// @riverpod
// class Judgment extends _$Judgment {
//   @override
//   FutureOr<VoteViewState> build({required String roomId}) async {
//     // 메시지와 투표 데이터를 동시에 가져옴
//     final messagesFuture =
//         ref.read(messageRepositoryProvider).getMessages(roomId);
//
//     // 투표 데이터 확인 및 없으면 기본 투표 데이터 생성
//     final voteFuture = await ref.read(voteRepositoryProvider).getVote(roomId);
//     late Vote vote; // 나중에 초기화할 수 있도록 'late' 키워드 사용
//
//     if (voteFuture == null) {
//       await ref.read(voteRepositoryProvider).createVote(
//             voteId: roomId,
//             roomId: roomId,
//             personName: 'kim',
//           );
//     } else {
//       vote = voteFuture; // 투표 데이터가 있으면 그 값을 사용
//     }
//
//     // 메시지 데이터를 가져옴
//     final messages = await messagesFuture;
//
//     // VoteViewState로 초기 상태 설정
//     return VoteViewState(messages: messages, vote: vote);
//   }
//   //
//   // @override
//   // FutureOr<VoteViewState> build({required String roomId}) async {
//   //   // 메시지와 투표 데이터를 동시에 가져옴
//   //   final messagesFuture =
//   //   ref.read(messageRepositoryProvider).getMessages(roomId);
//   //   final voteFuture = ref.read(voteRepositoryProvider).getVote(roomId);
//   //
//   //   // 병렬로 두 작업을 처리
//   //   final results = await Future.wait([messagesFuture, voteFuture]);
//   //
//   //   final messages = results[0] as List<Message>;
//   //   final vote = results[1] as Vote;
//   //
//   //   // VoteViewState로 초기 상태 설정
//   //   return VoteViewState(messages: messages, vote: vote);
//   // }
//
//   Future<void> sendMessage({
//     required String roomId,
//     String? userId,
//     required String message,
//     Timestamp? sentAt,
//   }) async {
//     // state = const AsyncLoading<List<Message>>();
//     state = state.whenData((currentMessages) => currentMessages);
//
//     state = await AsyncValue.guard(() async {
//       ref.read(messageRepositoryProvider).sendMessage(
//             roomId: roomId,
//             userId: fbAuth.currentUser!.uid,
//             message: message,
//             sentAt: Timestamp.now(),
//           );
//       final updatedMessages =
//           await ref.read(messageRepositoryProvider).getMessages(roomId);
//       return state.value!.copyWith(messages: updatedMessages);
//     });
//   }
//
//   /// 투표 업데이트
//   Future<void> castVote({
//     required String roomId,
//     String? userId,
//     required bool isGuilty,
//   }) async {
//     state = state.whenData((currentState) => currentState);
//
//     state = await AsyncValue.guard(() async {
//       await ref.read(voteRepositoryProvider).updateVote(
//             roomId: roomId,
//             userId: fbAuth.currentUser!.uid,
//             isGuilty: isGuilty,
//           );
//
//       final updatedVote =
//           await ref.read(voteRepositoryProvider).getVote(roomId);
//
//       // ResultViewModel에 투표 결과 업데이트를 알립니다.
//       ref.read(resultViewModelProvider.notifier).updateVoteResult(
//             roomId: roomId,
//             guiltyCount: updatedVote.guiltyCount,
//             notGuiltyCount: updatedVote.notGuiltyCount,
//           );
//
//       return state.value!.copyWith(vote: updatedVote);
//     });
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:up_down/src/model/vote.dart';
import 'package:up_down/src/model/message.dart';
import 'package:up_down/src/provider/home_repository_provider.dart';
import 'package:up_down/src/provider/image_repository_provider.dart';
import 'package:up_down/src/provider/message_repository_provider.dart';
import 'package:up_down/src/provider/profile_repository_provider.dart';
import 'package:up_down/src/provider/vote_repository_provider.dart';
import 'package:up_down/src/view/chat/vote/vote_view_state.dart';
import 'package:up_down/util/helper/firebase_helper.dart';
import 'package:up_down/util/helper/handle_exception.dart';

part 'vote_provider.g.dart';

@riverpod
class Judgment extends _$Judgment {
  @override
  Stream<VoteViewState> build({required String roomId}) async* {
    ref.onDispose(() {
      ref
          .read(homeRepositoryProvider)
          .removeParticipant(roomId, fbAuth.currentUser!.uid);
    });
    final messagesStream =
        ref.read(messageRepositoryProvider).getMessagesStream(roomId);
    final voteStream = ref.read(voteRepositoryProvider).getVoteStream(roomId);

    // 두 개의 스트림을 병합하여 하나의 상태로 관리
    await for (final combinedData in CombineLatestStream.combine2(
      messagesStream,
      voteStream,
      (messages, vote) {
        return VoteViewState(messages: messages, vote: vote);
      },
    )) {
      yield combinedData;
    }
  }

  /// 이미지 전송 함수
  Future<void> sendImage({
    required String roomId,
    required bool isMyTurn,
  }) async {
    try {
      // ImagePicker로 사용자에게 이미지 선택
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        // Firebase Storage에 이미지 업로드
        final downloadUrl =
            await ref.read(imageRepositoryProvider).uploadImage(image);

        if (downloadUrl != null) {
          // 업로드된 이미지의 다운로드 URL을 메시지로 전송
          final profile = await ref
              .read(profileRepositoryProvider)
              .getProfile(uid: fbAuth.currentUser!.uid);
          final userName = profile.name;

          await ref.read(messageRepositoryProvider).sendMessage(
                roomId: roomId,
                userId: fbAuth.currentUser!.uid,
                name: userName,
                message: downloadUrl, // 이미지 URL을 메시지로 전송
                sentAt: Timestamp.now(),
                isMyTurn: isMyTurn,
              );
        }
      }
    } catch (e) {
      throw handleException(e); // 에러 처리
    }
  }

  /// 메시지 전송 함수
  Future<void> sendMessage({
    required String roomId,
    String? userId,
    String? name,
    required String message,
    Timestamp? sentAt,
    required bool isMyTurn,
  }) async {
    try {
      // ProfileRepository에서 사용자 이름 가져오기
      final profile = await ref
          .read(profileRepositoryProvider)
          .getProfile(uid: fbAuth.currentUser!.uid);

      final userName = profile.name; // 가져온 사용자 이름

      // 메시지 전송
      ref.read(messageRepositoryProvider).sendMessage(
            roomId: roomId,
            userId: fbAuth.currentUser!.uid,
            name: userName, // 가져온 사용자 이름을 메시지에 포함
            message: message,
            sentAt: sentAt ?? Timestamp.now(),
            isMyTurn: isMyTurn,
          );
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> castVote({
    required String roomId,
    String? userId,
    required bool isGuilty,
  }) async {
    // 투표 업데이트
    await ref.read(voteRepositoryProvider).updateVote(
          roomId: roomId,
          userId: fbAuth.currentUser!.uid,
          isGuilty: isGuilty,
        );
  }
}
