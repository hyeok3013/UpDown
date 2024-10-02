import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/push_notification_provider.dart';

class PushNotificationToggle extends ConsumerWidget {
  const PushNotificationToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pushNotificationEnabled = ref.watch(pushNotificationEnabledProvider);
    final pushNotificationService = ref.watch(pushNotificationServiceProvider);
    final localNotificationService =
        ref.watch(localNotificationServiceProvider);

    return ListTile(
      enabled: pushNotificationEnabled,
      title: const Text('Push Notification'),
      subtitle: Text('Enabled: $pushNotificationEnabled'),
      trailing: Switch(
        onChanged: (bool value) {
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
