import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme_provider.dart';

class ThemeToggle extends ConsumerWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);

    return ListTile(
      title: Text(
        isDarkMode ? '다크 모드' : '라이트 모드',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: const Text('어두운 모드와 밝은 모드 전환'),
      trailing: Switch(
        onChanged: (bool? value) {
          themeNotifier.toggleTheme();
        },
        value: !isDarkMode,
        thumbIcon:
            WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
          return !isDarkMode
              ? const Icon(
                  Icons.wb_sunny,
                  color: Colors.black,
                )
              : const Icon(Icons.nightlight_round);
        }),
      ),
    );
  }
}
