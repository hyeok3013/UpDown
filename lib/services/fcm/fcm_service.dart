import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFunctions _functions =
      FirebaseFunctions.instanceFor(region: 'asia-northeast3');

  bool _isNotificationEnabled = true; //^ 알림 활성화 상태를 저장하는 변수

  void setNotificationEnabled(bool enabled) {
    //^ 알림 활성화 상태를 설정하는 메서드
    _isNotificationEnabled = enabled;
  }

  Future<void> initialize() async {
    try {
      await _requestPermissions();
      await _configureFCM();
    } catch (e) {
      print('Error initializing push notification service: $e');
    }
  }

  Future<void> updateFCMToken(String token) async {
    if (!_isNotificationEnabled) return; //^ 알림이 비활성화되어 있으면 토큰 업데이트 건너뛰기
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'fcmToken': token,
        });
        print('FCM token updated for user: ${user.uid}');
      } else {
        print('User not logged in, FCM token not updated');
      }
    } catch (e) {
      print('Error updating FCM token: $e');
    }
  }

  Future<void> sendNotification({
    required String title,
    required String body,
    required String pushToken,
  }) async {
    if (!_isNotificationEnabled) return; //^ 알림이 비활성화되어 있으면 알림 전송 건너뛰기
    try {
      // 여기에 기존의 sendNotification 로직을 유지합니다.
    } catch (e) {
      print('Failed to send push notification: $e');
    }
  }

  Future<void> _requestPermissions() async {
    final settings = await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      print('User declined or has not accepted permission for notifications');
    }
  }

  Future<void> _configureFCM() async {
    // 여기에 기존의 FCM 설정 로직을 유지합니다.
  }

  Future<String?> getToken() async {
    if (!_isNotificationEnabled) return null; //^ 알림이 비활성화되어 있으면 null 반환
    try {
      return await _firebaseMessaging.getToken();
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }

  //방생성 버튼 로직
  Future<void> sendRoomCreationNotification({
    required String roomName,
    required String creatorName,
  }) async {
    if (!_isNotificationEnabled) {
      //^ 알림이 비활성화되어 있으면 함수 종료
      print('Notifications are disabled. Skipping room creation notification.');
      return;
    }
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        print('User not logged in, cannot send notification');
        return;
      }

      String? token = await getToken();
      if (token == null) {
        print('FCM token is null, cannot send notification');
        return;
      }

      HttpsCallable callable = _functions.httpsCallable('sendPushNotification');
      final result = await callable.call({
        'title': "새로운 방 생성: $roomName",
        'body': "$creatorName 님이 새로운 방을 만들었습니다.",
        'userId': user.uid, // 토큰 대신 userId를 전송
      });

      print('Push notification sent successfully: ${result.data}');
    } catch (e) {
      print('Failed to send push notification: $e');
      rethrow; // 에러를 상위로 전파하여 UI에서 처리할 수 있게 함
    }
  }
}
