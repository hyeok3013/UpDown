import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:up_down/component/error_dialog.dart';
import 'package:up_down/src/model/custom_error.dart';
import 'package:up_down/src/model/room.dart';
import 'package:up_down/src/provider/auth_repository_provider.dart';
import 'package:up_down/src/view/chat/chat_provider.dart';
import 'package:up_down/util/helper/firebase_helper.dart';
import 'package:up_down/util/router/route_names.dart';

class ChatView extends ConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // room 객체는 방을 생성하는데 사용됨
    final docRef = FirebaseFirestore.instance.collection('rooms').doc();
    final roomId = docRef.id; // Firestore가 자동 생성한 고유 ID 사용

    // room 객체는 방을 생성하는데 사용됨
    final room = Room(
      roomId: roomId, // 고유한 방 ID
      roomName: 'Flutter Study Group',
      personName: 'Kim',
      imageUrl: 'https://example.com/image.png',
      roomStartDate: DateTime.now(),
      roomEndDate: DateTime.now().add(const Duration(hours: 1)),
    );

    // 방 리스트에 대한 상태를 가져옴
    final roomState = ref.watch(chatProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Rooms'),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await ref.read(authRepositoryProvider).signout();
              } on CustomError catch (e) {
                if (!context.mounted) return;
                errorDialog(context, e);
              }
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              ref.read(chatProvider.notifier).createRoom(room);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: roomState.when(
        skipLoadingOnRefresh: false,
        data: (rooms) {
          // 방 리스트가 있을 경우
          if (rooms.isEmpty) {
            return const Center(
              child: Text('방이 없습니다.'),
            );
          }

          // 방 리스트를 ListView로 보여줌
          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              return ListTile(
                leading: room.imageUrl.isNotEmpty
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(room.imageUrl),
                      )
                    : const CircleAvatar(
                        child: Icon(Icons.group),
                      ),
                title: Text(room.roomName),
                subtitle: Text(
                    '만든 사람: ${room.personName}\n시작: ${room.roomStartDate}'),
                onTap: () {
                  context.goNamed(
                    RouteNames.vote,
                    pathParameters: {
                      'roomId': room.roomId
                    }, // roomId를 params로 전달
                  ); //
                },
              );
            },
          );
        },
        error: (e, _) {
          final error = e as CustomError;

          return Center(
            child: Text(
              'code: ${error.code}\nplugin: ${error.plugin}\nmessage: ${error.message}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
