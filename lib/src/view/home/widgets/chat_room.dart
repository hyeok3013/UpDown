// lib/src/view/home/widgets/chat_room.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:up_down/src/provider/home_repository_provider.dart';
import 'package:up_down/util/helper/firebase_helper.dart';
import 'package:up_down/util/router/route_names.dart';

class ChatRoom extends ConsumerWidget {
  final String personName;
  final String roomId;
  final String roomName;
  final String roomStartDate;
  final String roomEndDate;
  final String imageUrl; // 추가된 부분: 이미지 URL
  final List<String> participants; // 추가된 부분: 이미지 URL

  const ChatRoom({
    super.key,
    required this.personName,
    required this.roomName,
    required this.roomStartDate,
    required this.roomEndDate,
    required this.imageUrl,
    required this.roomId, // 이미지 URL 매개변수 추가
    required this.participants,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref
            .read(homeRepositoryProvider)
            .addParticipant(roomId, fbAuth.currentUser!.uid);
        context.goNamed(
          RouteNames.vote,
          pathParameters: {'roomId': roomId}, // roomId를 경로로 전달
          extra: {
            'roomId': roomId,
            'roomName': roomName,
            'personName': personName,
            'participants': participants
          }, // 필요한 데이터를 Map으로 전달
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurStyle: BlurStyle.outer,
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 프로필 이미지 추가
            ClipOval(
              child: Image.network(
                imageUrl, // 이미지 URL을 사용하여 이미지를 로드
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return ClipOval(
                    child: Image.asset(
                      'assets/images/default_profile_black.png',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 14.0),
            Container(
              width: 1,
              height: 75,
              color: Colors.redAccent,
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    personName,
                    style: const TextStyle(
                      fontSize: 18.0,
                      // color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    roomName,
                    style: const TextStyle(
                      fontSize: 15.0,
                      // color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    '$roomStartDate - $roomEndDate'.replaceAllMapped(
                      RegExp(r'(\d{4})-(\d{2})-(\d{2})'),
                      (Match m) => '${m[1]!.substring(2)}/${m[2]}/${m[3]}',
                    ),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         fixedSize: const Size(69, 40),
            //       ),
            //       onPressed: () {
            //         ref
            //             .read(homeRepositoryProvider)
            //             .addParticipant(roomId, fbAuth.currentUser!.uid);
            //         context.goNamed(
            //           RouteNames.vote,
            //           pathParameters: {'roomId': roomId}, // roomId를 params로 전달
            //         );
            //       },
            //       child: const Text(
            //         '입장',
            //         style: TextStyle(
            //           fontSize: 12,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
