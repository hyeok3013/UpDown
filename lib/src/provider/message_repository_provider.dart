import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:up_down/src/repository/message_repository.dart';

part 'message_repository_provider.g.dart';

@riverpod
MessageRepository messageRepository(MessageRepositoryRef ref) {
  return MessageRepository();
}
