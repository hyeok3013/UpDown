import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:up_down/src/model/room.dart';
import 'package:up_down/src/model/vote.dart';
import 'package:up_down/src/repository/vote_repository.dart';

import 'result_view_state.dart';

final resultViewModelProvider =
    StateNotifierProvider<ResultViewModel, ResultViewState>((ref) {
  return ResultViewModel();
});

class ResultViewModel extends StateNotifier<ResultViewState> {
  ResultViewModel() : super(const ResultViewState.loading()) {
    _initializeStreams();
  }

  final VoteRepository _voteRepository = VoteRepository();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription? _roomsSubscription;
  Map<String, StreamSubscription> _voteSubscriptions = {};

  void _initializeStreams() {
    _roomsSubscription = _firestore
        .collection('rooms')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen(_handleRoomsSnapshot);
  }

  void _handleRoomsSnapshot(QuerySnapshot snapshot) {
    for (var change in snapshot.docChanges) {
      switch (change.type) {
        case DocumentChangeType.added:
          _subscribeToVoteUpdates(change.doc.id);
          break;
        case DocumentChangeType.modified:
          // Handle room modifications if needed
          break;
        case DocumentChangeType.removed:
          _unsubscribeFromVoteUpdates(change.doc.id);
          break;
      }
    }
    _updateResults(snapshot.docs);
  }

  void _subscribeToVoteUpdates(String roomId) {
    _voteSubscriptions[roomId] = _voteRepository
        .getVoteStream(roomId)
        .listen((voteData) => _updateVoteResult(roomId, voteData));
  }

  void _unsubscribeFromVoteUpdates(String roomId) {
    _voteSubscriptions[roomId]?.cancel();
    _voteSubscriptions.remove(roomId);
  }

  void _updateVoteResult(String roomId, Vote voteData) {
    state.whenOrNull(
      success: (currentResults) {
        final updatedResults = currentResults.map((item) {
          if (item.id == roomId) {
            final totalVotes = voteData.guiltyCount + voteData.notGuiltyCount;
            final forPercentage = totalVotes > 0
                ? (voteData.guiltyCount / totalVotes) * 100
                : 0.0;
            final againstPercentage = totalVotes > 0
                ? (voteData.notGuiltyCount / totalVotes) * 100
                : 0.0;

            return item.copyWith(
              forPercentage: forPercentage,
              againstPercentage: againstPercentage,
              isWinner: voteData.guiltyCount > voteData.notGuiltyCount,
              participantCount: voteData.participants.length,
              guiltyCount: voteData.guiltyCount,
              notGuiltyCount: voteData.notGuiltyCount,
            );
          }
          return item;
        }).toList();

        state = ResultViewState.success(updatedResults);
      },
    );
  }

  Future<void> _updateResults(List<QueryDocumentSnapshot> docs) async {
    try {
      final results = await Future.wait(docs.map((doc) async {
        final data = doc.data() as Map<String, dynamic>;
        final roomId = doc.id;

        final voteData = await _voteRepository.getVoteStream(roomId).first;

        final roomStartDate = (data['roomStartDate'] as Timestamp).toDate();
        final roomEndDate = (data['roomEndDate'] as Timestamp).toDate();

        final totalVotes = voteData.guiltyCount + voteData.notGuiltyCount;
        final forPercentage =
            totalVotes > 0 ? (voteData.guiltyCount / totalVotes) * 100 : 0.0;
        final againstPercentage =
            totalVotes > 0 ? (voteData.notGuiltyCount / totalVotes) * 100 : 0.0;

        return VoteResultItem(
          id: doc.id,
          title: data['roomName'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
          personName: data['personName'] ?? 'NoName',
          participants: List<String>.from(data['participants'] ?? []),
          forPercentage: forPercentage,
          againstPercentage: againstPercentage,
          isWinner: voteData.guiltyCount > voteData.notGuiltyCount,
          participantCount: voteData.participants.length,
          roomStartDate: roomStartDate,
          roomEndDate: roomEndDate,
          guiltyCount: voteData.guiltyCount,
          notGuiltyCount: voteData.notGuiltyCount,
        );
      }));

      state = ResultViewState.success(results);
    } catch (e) {
      state = ResultViewState.error(e.toString());
    }
  }

  Future<void> refreshResults() async {
    final snapshot = await _firestore
        .collection('rooms')
        .orderBy('createdAt', descending: true)
        .get();
    _updateResults(snapshot.docs);
  }

  Future<void> addNewRoom(Room room) async {
    final roomRef = _firestore.collection('rooms').doc(room.roomId);
    await roomRef.set({
      'roomId': room.roomId,
      'roomName': room.roomName,
      'imageUrl': room.imageUrl,
      'participantCount': room.participantCount,
      'roomStartDate': room.roomStartDate,
      'roomEndDate': room.roomEndDate,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // 새 방을 생성할 때 기본 투표 데이터도 생성
    await _voteRepository.createVote(
      voteId: room.roomId,
      roomId: room.roomId,
      personName: room.roomName,
    );
  }

  @override
  void dispose() {
    _roomsSubscription?.cancel();
    for (var subscription in _voteSubscriptions.values) {
      subscription.cancel();
    }
    super.dispose();
  }
}
