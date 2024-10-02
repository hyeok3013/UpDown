import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/local_notification/local_notification_service.dart';

final pushNotificationEnabledProvider = StateProvider<bool>((ref) => false);

class PushNotificationService {
  void setNotificationEnabled(bool value) {
    // 여기에 실제 푸시 알림 활성화/비활성화 로직을 구현하세요
    print('Push notification ${value ? 'enabled' : 'disabled'}');
  }
}

final pushNotificationServiceProvider =
    Provider((ref) => PushNotificationService());

final localNotificationServiceProvider =
    Provider((ref) => LocalNotificationService());
