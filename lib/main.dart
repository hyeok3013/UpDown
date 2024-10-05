import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:up_down/services/fcm/fcm_service.dart';
import 'package:up_down/theme/colors.dart';
import 'package:up_down/util/router/route_path.dart';

import 'firebase_options.dart';
import 'src/view/setting/theme_toggle/theme_provider.dart';

// 백그라운드 메시지 핸들러
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  // 여기에 백그라운드 알림 처리 로직 추가
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Facebook SDK 초기화
  await FacebookAuth.instance.autoLogAppEventsEnabled(true);

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.deviceCheck,
  );

  // // Firebase Analytics 초기화 (필요한 경우)
  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // 푸시 알림 서비스 초기화
  final pushNotificationService = PushNotificationService();
  await pushNotificationService.initialize();

  // FCM 토큰 가져오기 및 저장
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  if (fcmToken != null) {
    await pushNotificationService.updateFCMToken(fcmToken);
    print("FCM Token: $fcmToken");
  }

  // FCM 토큰 리프레시 리스너 설정
  FirebaseMessaging.instance.onTokenRefresh.listen((String token) {
    pushNotificationService.updateFCMToken(token);
    print("FCM Token refreshed: $token");
  });

  // 백그라운드 메시지 핸들러 등록
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 로컬 알림 설정
  // 로컬 알림 설정
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

// Android 설정
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

// iOS 설정
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

// 초기화 설정 통합
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

// 플러그인 초기화
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // 알림 응답 처리 (선택사항)
      print('알림 응답: ${response.payload}');
    },
  );

  KakaoSdk.init(
    nativeAppKey: '8651f6dc6fc750797c43905375bead6e',
    javaScriptAppKey: '5990f0f6119e8cad08a8141738412106',
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routeProvider);
    final isDarkMode = ref.watch(themeProvider);

    // 포그라운드 메시지 핸들링
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received a foreground message: ${message.notification?.title}");
      _showNotification(message);
    });

    // 알림 클릭 핸들링
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification clicked!");
      // 여기에 알림 클릭 시 처리 로직 추가 (예: 특정 화면으로 이동)
    });

    return MaterialApp.router(
      title: 'UP DOWN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          surfaceTintColor: isDarkMode ? Colors.black : Colors.white,
        ),
        colorScheme: isDarkMode
            ? const ColorScheme.dark(
                primary: AppColors.darkfocusColor,
                // secondary: AppColors.darkfocusColor,
              )
            : const ColorScheme.light(
                primary: AppColors.lightfocusColor,
                // secondary: AppColors.lightfocusColor,
              ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }

  void _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await FlutterLocalNotificationsPlugin().show(
      0,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platformChannelSpecifics,
      payload: message.data['route'],
    );
  }
}
