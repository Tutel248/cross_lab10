import 'package:flutter/material.dart';
import 'screens/text_previewer_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Text Previewer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD0BCFF),
          primary: const Color(0xFF6750A4),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F2FA),
      ),
      home: const TextPreviewerScreen(),
    );
  }
}