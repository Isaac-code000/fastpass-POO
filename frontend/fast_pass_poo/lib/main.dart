import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'features/splash/splash_screen.dart';

void main() {
  runApp(const FastPassApp());
}

class FastPassApp extends StatelessWidget {
  const FastPassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FastPass',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}
