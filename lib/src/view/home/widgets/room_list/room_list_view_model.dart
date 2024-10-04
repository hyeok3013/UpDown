// lib/src/view/home/widgets/room_list_view_model.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:up_down/src/model/room.dart';
import 'package:up_down/src/provider/home_repository_provider.dart';

part 'room_list_view_model.g.dart';

@Riverpod(keepAlive: true)
Stream<List<Room>> roomListViewModel(RoomListViewModelRef ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return repository.getChatRooms();
}
