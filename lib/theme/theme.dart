import 'package:flutter/material.dart';

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  // 라이트 모드 컬러 스킴
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff555a92),
      surfaceTint: Color(0xff555a92),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffe0e0ff),
      onPrimaryContainer: Color(0xff10144b),
      secondary: Color(0xff5c5d72),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe1e0f9),
      onSecondaryContainer: Color(0xff191a2c),
      tertiary: Color(0xff5e5791),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe4dfff),
      onTertiaryContainer: Color(0xff1a1249),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffbf8ff),
      onSurface: Color(0xff1b1b21),
      surfaceContainerHighest: Color(0xff46464f),
      onSurfaceVariant: Color(0xfff5f2fa),
      outline: Color(0xff777680),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303036),
      onInverseSurface: Color(0xffe4e1e9),
      inversePrimary: Color(0xffbec2ff),
    );
  }

  // 다크 모드 컬러 스킴
  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffbec2ff),
      surfaceTint: Color(0xffbec2ff),
      onPrimary: Color(0xff262b60),
      primaryContainer: Color(0xff3d4279),
      onPrimaryContainer: Color(0xffe0e0ff),
      secondary: Color(0xffc5c4dd),
      onSecondary: Color(0xff2e2f42),
      secondaryContainer: Color(0xff444559),
      onSecondaryContainer: Color(0xffe1e0f9),
      tertiary: Color(0xffc7bfff),
      onTertiary: Color(0xff2f295f),
      tertiaryContainer: Color(0xff463f77),
      onTertiaryContainer: Color(0xffe4dfff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff131318),
      onSurface: Color(0xffe4e1e9),
      surfaceContainerHighest: Color(0xffc7c5d0),
      onSurfaceVariant: Color(0xff46464f),
      outline: Color(0xff91909a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e1e9),
      onInverseSurface: Color(0xff131318),
      inversePrimary: Color(0xff555a92),
    );
  }

  // 라이트 모드 테마
  ThemeData light() {
    return theme(lightScheme());
  }

  // 다크 모드 테마
  ThemeData dark() {
    return theme(darkScheme());
  }

  // ThemeData를 생성하는 메서드
  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: colorScheme.outline,
            ),
          ),
        ),
      );
}
