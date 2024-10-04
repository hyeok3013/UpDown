import 'package:flutter/material.dart';

class PushNotificationToggle extends StatefulWidget {
  const PushNotificationToggle({super.key});

  @override
  State<PushNotificationToggle> createState() => PushNotificationToggleState();
}

class PushNotificationToggleState extends State<PushNotificationToggle> {
  bool _pushNotificationToggle = true;

  void _togglePushNotifications(bool enable) {
    setState(() {
      _pushNotificationToggle = enable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: _pushNotificationToggle,
      title: const Text(
        '푸쉬 알림 설정',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _pushNotificationToggle
          ? const Text('허용 여부: 켜짐')
          : const Text('허용 여부: 꺼짐'),
      trailing: Switch(
        onChanged: (bool? value) {
          _togglePushNotifications(value!);
        },
        value: _pushNotificationToggle,
      ),
    );
  }
}
