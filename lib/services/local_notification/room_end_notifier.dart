// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:up_down/services/local_notification/local_notification_service.dart';
//
// class RoomEndNotifier extends StateNotifier<void> {
//   final FirebaseFirestore _firestore;
//   final LocalNotificationService _notificationService;
//   final List<StreamSubscription<DocumentSnapshot>> _subscriptions = [];
//
//   RoomEndNotifier(this._firestore, this._notificationService) : super(null) {
//     _listenToRooms();
//   }
//
//   void _listenToRooms() {
//     final roomsQuery = _firestore
//         .collection('rooms')
//         .where('roomEndDate', isGreaterThan: Timestamp.now());
//
//     roomsQuery.get().then((querySnapshot) {
//       for (var doc in querySnapshot.docs) {
//         final roomId = doc.id;
//         final endDate = (doc.data()['roomEndDate'] as Timestamp).toDate();
//         _subscribeToRoom(roomId, endDate);
//       }
//     });
//   }
//
//   void _subscribeToRoom(String roomId, DateTime endDate) {
//     // 미리 subscription 변수를 선언합니다.
//     StreamSubscription<DocumentSnapshot>? subscription;
//
//     subscription = _firestore
//         .collection('rooms')
//         .doc(roomId)
//         .snapshots()
//         .listen((snapshot) {
//       if (snapshot.exists) {
//         final currentEndDate =
//             (snapshot.data()?['roomEndDate'] as Timestamp).toDate();
//         if (currentEndDate.isBefore(DateTime.now().toUtc())) {
//           //^ UTC 변환 추가
//           _notificationService.showNotification(
//             id: roomId.hashCode,
//             title: '채팅방 종료',
//             body: '채팅방이 종료되었습니다.',
//           );
//           _cancelSubscription(subscription!);
//         }
//       }
//     }, onError: (error) {
//       print('Error listening to room $roomId: $error'); //^ 구독 오류 처리 추가
//     });
//
//     // 선언 후 subscription을 추가합니다.
//     _subscriptions.add(subscription);
//   }
//
//   void _cancelSubscription(StreamSubscription<DocumentSnapshot> subscription) {
//     subscription.cancel();
//     _subscriptions.remove(subscription);
//   }
//
//   @override
//   void dispose() {
//     for (var subscription in _subscriptions) {
//       subscription.cancel();
//     }
//     _subscriptions.clear();
//     super.dispose();
//   }
// }
//
// final roomEndNotifierProvider =
//     StateNotifierProvider<RoomEndNotifier, void>((ref) {
//   final firestore = FirebaseFirestore.instance;
//   final notificationService = LocalNotificationService();
//   return RoomEndNotifier(firestore, notificationService);
// });
