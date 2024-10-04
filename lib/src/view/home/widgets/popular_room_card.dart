// lib/src/view/home/widgets/popular_room_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:up_down/src/provider/home_repository_provider.dart';
import 'package:up_down/util/helper/firebase_helper.dart';
import 'package:up_down/util/router/route_names.dart';

class PopularRoomCard extends ConsumerWidget {
  final String personName;
  final String roomId;
  final String roomName;
  final String imageUrl; // 이미지 URL
  final List<String> participants;
  final int participantCount;

  const PopularRoomCard({
    super.key,
    required this.personName,
    required this.roomName,
    required this.imageUrl,
    required this.roomId,
    required this.participants,
    required this.participantCount,
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
          pathParameters: {'roomId': roomId},
          extra: {
            'roomId': roomId,
            'roomName': roomName,
            'personName': personName,
            'participants': participants
          },
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.network(
                  imageUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return ClipOval(
                      child: Image.asset(
                        'assets/images/default_profile_black.png',
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Text(
                personName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                roomName,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                '참가자 수: $participantCount',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
