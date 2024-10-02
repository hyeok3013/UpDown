import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:up_down/src/view/result/result_view_model.dart';

//dsf
import 'result_view_state.dart';

class ResultView extends ConsumerStatefulWidget {
  const ResultView({Key? key}) : super(key: key);

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends ConsumerState<ResultView> {
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    final fcmToken = await fcm.getToken();
    print('FCM Token: $fcmToken');
  }

  @override
  void initState() {
    super.initState();
    setupPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(resultViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('투표 결과'),
        backgroundColor: Colors.red,
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (message) => Center(child: Text('Error: $message')),
        success: (results) => RefreshIndicator(
          onRefresh: () =>
              ref.read(resultViewModelProvider.notifier).refreshResults(),
          child: results.isEmpty
              ? const Center(child: Text('아직 생성된 방이 없습니다.'))
              : ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) =>
                      VoteResultCard(item: results[index]),
                ),
        ),
      ),
    );
  }
}

class VoteResultCard extends StatelessWidget {
  final VoteResultItem item;

  const VoteResultCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = DateTime.now().isAfter(item.roomEndDate);

    return GestureDetector(
      onTap: isCompleted
          ? null
          : () {
              context.push('/chat/vote/${item.id}');
            },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 4,
        child: MouseRegion(
          cursor:
              isCompleted ? SystemMouseCursors.basic : SystemMouseCursors.click,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.imageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(4)),
                  child: Image.network(
                    item.imageUrl,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 100,
                        color: Colors.grey[300],
                        child: const Center(child: Text('이미지를 불러올 수 없습니다.')),
                      );
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '참가자 수: ${item.participantCount}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '시작일: ${_formatDate(item.roomStartDate)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '종료일: ${_formatDate(item.roomEndDate)}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        if (isCompleted)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              '종료',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPercentageBar(
                          context,
                          item.forPercentage,
                          item.againstPercentage,
                          item.guiltyCount,
                          item.notGuiltyCount,
                        ),
                        _buildWinLoseIndicator(item.isWinner),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPercentageBar(
    BuildContext context,
    double forPercentage,
    double againstPercentage,
    int guiltyCount,
    int notGuiltyCount,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('잘못했다: ${forPercentage.toStringAsFixed(1)}% ($guiltyCount표)'),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: forPercentage / 100,
            backgroundColor: Colors.red[100],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          ),
          const SizedBox(height: 8),
          Text(
              '잘못하지 않았다: ${againstPercentage.toStringAsFixed(1)}% ($notGuiltyCount표)'),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: againstPercentage / 100,
            backgroundColor: Colors.blue[100],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildWinLoseIndicator(bool isWinner) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isWinner ? Colors.red : Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isWinner ? '나락' : '구원',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
