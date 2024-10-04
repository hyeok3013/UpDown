// lib/src/view/home/widgets/room_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:up_down/src/view/home/widgets/chat_room.dart';
import 'package:up_down/src/view/home/widgets/room_list/room_list_view_model.dart';

class RoomListPage extends ConsumerWidget {
  const RoomListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRoomsAsyncValue = ref.watch(roomListViewModelProvider);

    return chatRoomsAsyncValue.when(
      data: (chatRooms) {
        if (chatRooms.isEmpty) {
          return const Center(child: Text('No chat rooms available'));
        }
        return ListView.builder(
          itemCount: chatRooms.length,
          itemBuilder: (context, index) {
            final room = chatRooms[index];

            final roomStartDate =
                room.roomStartDate.toLocal().toString().substring(0, 10);
            final roomEndDate =
                room.roomEndDate.toLocal().toString().substring(0, 10);

            return ChatRoom(
              personName: room.personName,
              roomId: room.roomId,
              roomName: room.roomName,
              roomStartDate: roomStartDate,
              roomEndDate: roomEndDate,
              imageUrl: room.imageUrl,
              participants: room.participants,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
