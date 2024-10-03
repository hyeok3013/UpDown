// lib/src/view/home/home_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:up_down/src/provider/admin_repository_provider.dart';
import 'package:up_down/src/view/home/home_view_model.dart';
import 'package:up_down/src/view/home/widgets/popular_room_card.dart';
import 'package:up_down/src/view/home/widgets/room_list/room_list.dart';
import 'package:go_router/go_router.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);
    final isAdminAsyncValue = ref.watch(isAdminProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('핫이슈와 인물들'),
      ),
      body: Column(
        children: [
          // 인기 방 섹션
          SizedBox(
            height: 200,
            child: homeState.popularRooms.isEmpty
                ? const Center(child: Text('No popular rooms'))
                : PageView(
                    children: homeState.popularRooms.map((room) {
                      return PopularRoomCard(
                        roomId: room.roomId,
                        roomName: room.roomName,
                        personName: room.personName,
                        imageUrl: room.imageUrl,
                        participantCount: room.participantCount,
                        participants: room.participants,
                      );
                    }).toList(),
                  ),
          ),
          // 방 리스트
          const Expanded(child: RoomListPage()),
        ],
      ),
      floatingActionButton: isAdminAsyncValue.when(
        data: (isAdmin) => isAdmin
            ? FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: () {
                  context.go('/create-room');
                },
                child: const Icon(Icons.add),
              )
            : null,
        loading: () => const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        error: (error, stack) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to load admin status')),
            );
          });
          return null;
        },
      ),
    );
  }
}
