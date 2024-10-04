import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:up_down/src/model/custom_error.dart';
import 'package:up_down/src/model/message.dart';
import 'package:up_down/src/view/chat/vote/vote_provider.dart';
import 'package:up_down/theme/colors.dart';
import 'package:up_down/util/helper/firebase_helper.dart';

import '../../../../component/chat_app_text_field.dart';
import '../../../../component/message_bubble.dart';

class VoteView extends ConsumerStatefulWidget {
  final String roomId;
  final String roomName;
  final String personName;
  final List<String> participants;
  const VoteView({
    super.key,
    required this.roomId,
    required this.roomName,
    required this.personName,
    required this.participants,
  });

  @override
  _VoteViewState createState() => _VoteViewState();
}

class _VoteViewState extends ConsumerState<VoteView> {
  final TextEditingController _messageController = TextEditingController();
  final userId = fbAuth.currentUser!.uid;

  // 참가자 이름 리스트를 담을 상태 변수
  List<String> participantNames = [];

  @override
  void initState() {
    super.initState();
    _loadParticipantNames(); // Firestore에서 참가자 이름을 가져옴
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  // Firestore에서 participants 리스트의 userId를 personName으로 변환하는 함수
  Future<void> _loadParticipantNames() async {
    final List<String> names = [];

    for (String userId in widget.participants) {
      final userDoc = await usersCollection.doc(userId).get();
      if (userDoc.exists) {
        final userName = userDoc.data()?['name'] ?? 'Unknown';
        names.add(userName);
      }
    }

    // 상태 업데이트: 참가자 이름 리스트
    setState(() {
      participantNames = names;
    });
  }

  // 투표 다이얼로그 표시 함수
  Future<void> _showVoteDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // 다이얼로그 밖을 누르면 닫히지 않도록 설정
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('투표하기'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('투표는 신중하게 딱 한번만 가능합니다.'),
                SizedBox(height: 10),
                Text('어느 쪽에 투표하시겠습니까?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('잘못했다'),
              onPressed: () {
                ref
                    .read(judgmentProvider(roomId: widget.roomId).notifier)
                    .castVote(
                      roomId: widget.roomId,
                      isGuilty: true,
                    );
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
            TextButton(
              child: const Text('잘못하지 않았다'),
              onPressed: () {
                ref
                    .read(judgmentProvider(roomId: widget.roomId).notifier)
                    .castVote(
                      roomId: widget.roomId,
                      isGuilty: false,
                    );
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
          ],
        );
      },
    );
  }

  // 이미 투표한 경우의 다이얼로그
  Future<void> _showAlreadyVotedDialog(String voteChoice) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('투표 완료'),
          content: Text('당신은 "$voteChoice"에 투표하셨습니다.'),
          actions: <Widget>[
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  double _calculateVoteRatio(int guiltyCount, int notGuiltyCount) {
    if (guiltyCount + notGuiltyCount == 0) {
      return 0.5; // 투표가 없으면 50:50으로 표시
    }
    return guiltyCount / (guiltyCount + notGuiltyCount);
  }

  void _sendMessage(List<Message> messages) {
    FocusScope.of(context).unfocus();
    if (_messageController.text.isNotEmpty) {
      ref.read(judgmentProvider(roomId: widget.roomId).notifier).sendMessage(
            roomId: widget.roomId,
            message: _messageController.text,
            isMyTurn: _checkMyTurn(messages),
          );
    }
    _messageController.clear();
  }

  // isMyTurn을 위한 함수; 말풍선 UI를 위해 사용;
  bool _checkMyTurn(List<Message> messages) {
    if (messages.isEmpty) {
      // 첫 메시지는 무조건 false;
      return false;
    } else if (messages[0].userId != userId) {
      // 이전 메시지가 내가 보낸 것이 아니면 무조건 false;
      return false;
    } else {
      // 첫 메시지가 아니며 내가 보냈다면 true;
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // `judgmentProvider`에서 투표와 메시지를 함께 가져옴
    final messageState = ref.watch(judgmentProvider(roomId: widget.roomId));

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.focusRedColor,
                ),
                child: Text(
                  '토론 참가자 목록',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              if (participantNames.isEmpty)
                const ListTile(
                  title: Text('참가자가 없습니다'),
                )
              else
                ...participantNames.map((name) => ListTile(
                      title: Text(name),
                    )),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     messageState.whenOrNull(data: (voteViewState) {
        //       final userId = fbAuth.currentUser!.uid;
        //       final vote = voteViewState.vote;

        //       // 참가자에 대한 투표 정보를 확인하고 결과를 다이얼로그에 표시
        //       if (vote.participants.containsKey(userId)) {
        //         final userVote = vote.participants[userId]!;
        //         final voteChoice = userVote ? '잘못했다' : '잘못하지 않았다';
        //         _showAlreadyVotedDialog(voteChoice);
        //       } else {
        //         _showVoteDialog();
        //       }
        //     });
        //   },
        //   child: const Icon(Icons.how_to_vote),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                messageState.whenOrNull(data: (voteViewState) {
                  final userId = fbAuth.currentUser!.uid;
                  final vote = voteViewState.vote;

                  // 참가자에 대한 투표 정보를 확인하고 결과를 다이얼로그에 표시
                  if (vote.participants.containsKey(userId)) {
                    final userVote = vote.participants[userId]!;
                    final voteChoice = userVote ? '잘못했다' : '잘못하지 않았다';
                    _showAlreadyVotedDialog(voteChoice);
                  } else {
                    _showVoteDialog();
                  }
                });
              },
              icon: Image.asset(
                'assets/icons/vote_icon.png',
                width: 28,
                height: 28,
              ),
            ),
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    _loadParticipantNames();
                    // Builder로 제공된 context를 사용하여 드로어를 엽니다
                    Scaffold.of(context).openEndDrawer();
                  },
                );
              },
            ),
          ],
          title: Text('[${widget.personName}] ${widget.roomName}'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: messageState.when(
              data: (voteViewState) {
                final vote = voteViewState.vote;
                final voteRatio =
                    _calculateVoteRatio(vote.guiltyCount, vote.notGuiltyCount);

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '잘못했다: ${vote.guiltyCount}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '잘못하지 않았다: ${vote.notGuiltyCount}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // LinearProgressIndicator로 투표 비율 표시
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(5),
                        minHeight: 10,
                        value: voteRatio, // 투표 비율에 따라 프로그레스 바 업데이트
                        backgroundColor: Colors.green,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.redAccent),
                      ),
                    ),
                  ],
                );
              },
              error: (e, _) {
                return const SizedBox();
              },
              loading: () => const LinearProgressIndicator(),
            ),
          ),
        ),
        body: messageState.when(
          data: (voteViewState) {
            final messages = voteViewState.messages;
            return Column(
              children: [
                // 메시지와 투표 상태를 동시에 처리
                Expanded(
                  child: Column(
                    children: [
                      // 채팅 메시지 표시
                      Expanded(
                        child: messages.isEmpty
                            ? const Center(child: Text('메시지가 아직 없습니다'))
                            : ListView.builder(
                                reverse: true,
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                  final message = messages[index];
                                  return MessageBubble(
                                    message: message,
                                    myId: userId,
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.camera_alt), // 이미지 업로드 버튼
                        onPressed: () {
                          ref
                              .read(judgmentProvider(roomId: widget.roomId)
                                  .notifier)
                              .sendImage(
                                roomId: widget.roomId,
                                isMyTurn: _checkMyTurn(messages),
                              );
                        },
                      ),
                      Expanded(
                        child: ChatAppTextField(
                          controller: _messageController,
                          onPressed: () => _sendMessage(messages),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
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
    );
  }
}
