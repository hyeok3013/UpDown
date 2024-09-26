import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:up_down/src/model/room.dart';
import 'package:up_down/src/provider/room_repository_provider.dart';

part 'chat_provider.g.dart';

@riverpod
class RoomList extends _$RoomList {
  @override
  FutureOr<List<Room>> build() {
    return ref.read(roomRepositoryProvider).getRooms();
  }

  Future<void> createRoom(Room room) async {
    state = const AsyncLoading<List<Room>>();

    state = await AsyncValue.guard(
      () {
        ref.read(roomRepositoryProvider).createRoom(room);
        return ref.read(roomRepositoryProvider).getRooms();
      },
    );
  }

// Future<List<Room>> getRooms() async {
//   state = const AsyncLoading<List<Room>>();
//
//   state = await AsyncValue.guard(() async {
//     final rooms = await ref.read(roomRepositoryProvider).getRooms();
//     return rooms;
//   });
// }
}
