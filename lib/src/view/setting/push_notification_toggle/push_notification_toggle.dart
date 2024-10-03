import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/push_notification_provider.dart';

class PushNotificationToggle extends ConsumerStatefulWidget {
  const PushNotificationToggle({Key? key}) : super(key: key);

  @override
  _PushNotificationToggleState createState() => _PushNotificationToggleState();
}

class _PushNotificationToggleState
    extends ConsumerState<PushNotificationToggle> {
  bool pushNotificationToggle = true; // 초기값 설정

  void togglePushNotifications(bool enable) {
    setState(() {
      pushNotificationToggle = enable;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pushNotificationEnabled = ref.watch(pushNotificationEnabledProvider);
    final pushNotificationService = ref.watch(pushNotificationServiceProvider);
    final localNotificationService =
        ref.watch(localNotificationServiceProvider);

    return ListTile(
      enabled: pushNotificationToggle,
      title: const Text(
        '푸쉬 알림 설정',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: pushNotificationToggle
          ? const Text('허용 여부: 켜짐')
          : const Text('허용 여부: 꺼짐'),
      trailing: Switch(
        onChanged: (bool value) {
          togglePushNotifications(value);
          ref.read(pushNotificationEnabledProvider.notifier).state = value;
          pushNotificationService.setNotificationEnabled(value);
          localNotificationService.showNotification(
            '알림 설정',
            '알림 설정이 변경되었습니다.',
          );
        },
        value: pushNotificationEnabled,
      ),
    );
  }
}
