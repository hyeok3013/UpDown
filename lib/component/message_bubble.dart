import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:up_down/src/model/message.dart';
import 'package:up_down/theme/colors.dart';

class MessageBubble extends ConsumerWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.myId,
  });
  final Message message;
  final String myId;

  String _formatDateTime(DateTime dateTime) {
    // 12시간제를 위한 시간 계산
    int hour = dateTime.hour > 12
        ? dateTime.hour - 12
        : dateTime.hour == 0
            ? 12
            : dateTime.hour;
    String period = dateTime.hour >= 12 ? 'PM' : 'AM';
    String minute = dateTime.minute.toString().padLeft(2, '0');

    // 월, 일 형식
    String date = '${dateTime.month}/${dateTime.day}';

    return '$date $hour:$minute $period';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMe = message.userId == myId;

    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: !message.isMyTurn
          ? [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: isMe
                        ? [
                            Text(
                              _formatDateTime(message.sentAt.toDate())
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.greyColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              message.name,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ]
                        : [
                            Text(
                              message.name,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              _formatDateTime(message.sentAt.toDate())
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.greyColor,
                              ),
                            ),
                          ],
                  ),
                ),
              ),
              Padding(
                padding: isMe
                    ? const EdgeInsets.fromLTRB(100, 5, 0, 5)
                    : const EdgeInsets.fromLTRB(0, 5, 100, 5),
                child: Container(
                  decoration: BoxDecoration(
                    // 연속된 말풍선 색깔 설정
                    color: isMe
                        ? AppColors.sendMsgColor
                        : AppColors.receivedMsgColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: const Radius.circular(15),
                      bottomLeft: const Radius.circular(15),
                      topRight: isMe
                          ? const Radius.circular(0)
                          : const Radius.circular(15),
                      topLeft: isMe
                          ? const Radius.circular(15)
                          : const Radius.circular(0),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  margin: isMe
                      ? const EdgeInsets.only(right: 14)
                      : const EdgeInsets.only(left: 14),
                  child:
                      message.message.startsWith('http') // 메시지가 URL이면 이미지로 렌더링
                          //이미지 크기 세팅
                          ? Image.network(message.message)
                          : Text(
                              message.message,
                              style: TextStyle(
                                color: isMe ? Colors.black : Colors.white,
                              ),
                            ), // 텍스트 메시지,
                ),
              ),
            ]
          : [
              Padding(
                padding: isMe
                    ? const EdgeInsets.fromLTRB(100, 5, 0, 5)
                    : const EdgeInsets.fromLTRB(0, 5, 100, 5),
                child: Container(
                  decoration: BoxDecoration(
                    // 연속된 말풍선 색깔 설정
                    color: isMe
                        ? AppColors.sendMsgColor
                        : AppColors.receivedMsgColor,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  margin: isMe
                      ? const EdgeInsets.only(right: 14)
                      : const EdgeInsets.only(left: 14),
                  child:
                      message.message.startsWith('http') // 메시지가 URL이면 이미지로 렌더링
                          //이미지 크기 세팅
                          ? Image.network(message.message)
                          : Text(
                              message.message,
                              style: TextStyle(
                                color: isMe ? Colors.black : Colors.white,
                              ),
                            ), // 텍스트 메시지,
                ),
              ),
            ],
    );
  }
}
