import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:up_down/src/model/custom_error.dart';
import 'package:up_down/src/model/message.dart';
import 'package:up_down/src/view/chat/vote/vote_provider.dart';

class VoteView extends ConsumerStatefulWidget {
  final String roomId;
  const VoteView({super.key, required this.roomId});

  @override
  _VoteViewState createState() => _VoteViewState();
}

class _VoteViewState extends ConsumerState<VoteView> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messageState = ref.watch(voteProvider(roomId: widget.roomId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Room'),
      ),
      body: Column(
        children: [
          Expanded(
            child: messageState.when(
              data: (messages) {
                if (messages.isEmpty) {
                  return const Center(
                    child: Text('No messages yet'),
                  );
                }
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return ListTile(
                      title: Text(message.userId), // 유저 ID 표시 (추후 이름으로 변경 가능)
                      subtitle: Text(message.message),
                      trailing: Text(message.sentAt.toDate().toString()),
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      labelText: 'Enter message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    ref
                        .read(voteProvider(roomId: widget.roomId).notifier)
                        .sendMessage(
                            roomId: widget.roomId,
                            message: _messageController.text);
                    _messageController.clear();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
