import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:up_down/src/repository/room_repository.dart';

part 'room_repository_provider.g.dart';

@riverpod
RoomRepository roomRepository(RoomRepositoryRef ref) {
  return RoomRepository();
}
