// lib/src/repository/home_repository_impl.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:up_down/src/model/room.dart';
import 'package:up_down/src/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final FirebaseFirestore _firestore;

  HomeRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Room>> getPopularRooms() {
    final now = DateTime.now();
    return _firestore
        .collection('rooms')
        .where('roomEndDate', isGreaterThanOrEqualTo: Timestamp.fromDate(now))
        .orderBy('roomEndDate', descending: false)
        .orderBy('participantCount', descending: true)
        .limit(3)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Room.fromFirestore(doc)).toList())
        .handleError((error) {
      print('Error fetching popular rooms: $error');
    });
  }

  @override
  Stream<List<Room>> getChatRooms() {
    final now = DateTime.now();
    return _firestore
        .collection('rooms')
        .where('roomEndDate', isGreaterThanOrEqualTo: Timestamp.fromDate(now))
        .orderBy('roomEndDate', descending: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Room.fromFirestore(doc)).toList());
  }

  @override
  Future<void> createRoom(String roomName, String personName,
      DateTime roomStartDate, DateTime roomEndDate, String imageUrl) async {
    final roomRef = _firestore.collection('rooms').doc();
    final roomId = roomRef.id;

    await roomRef.set({
      'roomId': roomId,
      'roomName': roomName,
      'personName': personName,
      'roomStartDate': Timestamp.fromDate(roomStartDate),
      'roomEndDate': Timestamp.fromDate(roomEndDate),
      'imageUrl': imageUrl,
      'participantCount': 0,
      'createdAt': Timestamp.now(),
      'participants': [],
    });
  }

  @override
  Future<void> addParticipant(String roomId, String userId) async {
    DocumentReference roomRef = _firestore.collection('rooms').doc(roomId);

    await roomRef.update({
      'participants': FieldValue.arrayUnion([userId]),
      'participantCount': FieldValue.increment(1),
    });
  }

  @override
  Future<void> removeParticipant(String roomId, String userId) async {
    DocumentReference roomRef = _firestore.collection('rooms').doc(roomId);

    await roomRef.update({
      'participants': FieldValue.arrayRemove([userId]),
      'participantCount': FieldValue.increment(-1),
    });
  }
}
