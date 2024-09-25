import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:up_down/src/model/message.dart';

class VoteView extends ConsumerStatefulWidget {
  final String roomId;
  const VoteView({super.key, required this.roomId});

  @override
  _VoteViewState createState() => _VoteViewState();
}

class _VoteViewState extends ConsumerState<VoteView> {
  final TextEditingController _messageController = TextEditingController();

  Future<void> _sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    // Firestore에 저장할 데이터 맵으로 변환
    final newMessage = {
      'userId': 'exampleUserId', // 실제 유저 ID로 교체
      'message': content,
      'sentAt': Timestamp.now(),
    };

    await FirebaseFirestore.instance
        .collection('rooms_test')
        .doc(widget.roomId)
        .collection('messages')
        .add(newMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Room'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('rooms_test')
                  .doc(widget.roomId)
                  .collection('messages')
                  .orderBy('sentAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No messages yet'));
                }

                final messages = snapshot.data!.docs
                    .map((doc) => Message.fromDoc(doc))
                    .toList();

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
                    _sendMessage(_messageController.text);
                    _messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
