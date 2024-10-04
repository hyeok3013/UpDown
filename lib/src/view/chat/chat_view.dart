import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '채팅방', // ViewModel에서 roomId를 가져옴
        ),
      ),
      body: const Center(
        child: Text('참여하고 있는 채팅방이 없습니다.'),
      ),
    );
  }
}
