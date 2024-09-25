import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:up_down/src/model/message.dart';
import 'package:up_down/src/provider/auth_repository_provider.dart';
import 'package:up_down/src/provider/message_repository_provider.dart';
import 'package:up_down/util/helper/firebase_helper.dart';

part 'vote_provider.g.dart';

@riverpod
class Vote extends _$Vote {
  @override
  FutureOr<List<Message>> build({required String roomId}) async {
    return ref.read(messageRepositoryProvider).getMessages(roomId);
  }

  Future<void> sendMessage({
    required String roomId,
    String? userId,
    required String message,
    Timestamp? sentAt,
  }) async {
    // state = const AsyncLoading<List<Message>>();
    state = state.whenData((currentMessages) => currentMessages);

    state = await AsyncValue.guard(() {
      ref.read(messageRepositoryProvider).sendMessage(
            roomId: roomId,
            userId: fbAuth.currentUser!.uid,
            message: message,
            sentAt: Timestamp.now(),
          );

      return ref.read(messageRepositoryProvider).getMessages(roomId);
      ;
    });
  }
}
