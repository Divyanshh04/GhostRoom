import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/welcome/welcome_screen.dart';

void main() {
  runApp(const GhostRoomApp());
}

class GhostRoomApp extends StatelessWidget {
  const GhostRoomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GhostRoom',
      theme: AppTheme.darkTheme,
      home: const WelcomeScreen(),
    );
  }
}