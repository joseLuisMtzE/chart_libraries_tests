import 'package:flutter/material.dart';

const colorSeed = Color(0xFFff8623);

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF8623),
        ).copyWith(
          primary: const Color(0xFFFF8623), // Asigna el color específico
        ),
        fontFamily: 'Sora',
      );
}
