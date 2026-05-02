import 'package:flutter/material.dart';
import 'screens/title_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MurderMysteryApp());
}

class MurderMysteryApp extends StatelessWidget {
  const MurderMysteryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Murder Mystery',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(),
      home: const TitleScreen(),
    );
  }
}
