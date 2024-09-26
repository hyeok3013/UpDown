import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:up_down/src/model/custom_error.dart';
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
    // `judgmentProvider`에서 투표와 메시지를 함께 가져옴
    final messageState = ref.watch(judgmentProvider(roomId: widget.roomId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Room & Vote'),
      ),
      body: Column(
        children: [
          // 메시지와 투표 상태를 동시에 처리
          Expanded(
            child: messageState.when(
              data: (voteViewState) {
                final messages = voteViewState.messages;
                final vote = voteViewState.vote;

                return Column(
                  children: [
                    // 채팅 메시지 표시
                    Expanded(
                      child: messages.isEmpty
                          ? const Center(child: Text('No messages yet'))
                          : ListView.builder(
                              reverse: true,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                return ListTile(
                                  title: Text(message.userId), // 유저 ID 표시
                                  subtitle: Text(message.message),
                                  trailing:
                                      Text(message.sentAt.toDate().toString()),
                                );
                              },
                            ),
                    ),
                    // 투표 결과 표시
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Text('잘못한 사람: ${vote.guiltyCount}'),
                          Text('잘못하지 않은 사람: ${vote.notGuiltyCount}'),
                        ],
                      ),
                    ),
                    // 투표 버튼
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // "잘못했다" 투표 처리
                            ref
                                .read(judgmentProvider(roomId: widget.roomId)
                                    .notifier)
                                .castVote(
                                  roomId: widget.roomId,
                                  userId: 'currentUserId', // 실제 유저 ID로 교체
                                  isGuilty: true,
                                );
                          },
                          child: const Text('잘못했다'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // "잘못하지 않았다" 투표 처리
                            ref
                                .read(judgmentProvider(roomId: widget.roomId)
                                    .notifier)
                                .castVote(
                                  roomId: widget.roomId,
                                  userId: 'currentUserId', // 실제 유저 ID로 교체
                                  isGuilty: false,
                                );
                          },
                          child: const Text('잘못하지 않았다'),
                        ),
                      ],
                    ),
                  ],
                );
              },
              error: (e, _) {
                if (e is CustomError) {
                  return Center(
                    child: Text(
                      'code: ${e.code}\nplugin: ${e.plugin}\nmessage: ${e.message}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      'Unexpected error: $e',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  );
                }
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
                    // 메시지 전송
                    ref
                        .read(judgmentProvider(roomId: widget.roomId).notifier)
                        .sendMessage(
                          roomId: widget.roomId,
                          message: _messageController.text,
                        );
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
