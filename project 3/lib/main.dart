import 'package:flutter/material.dart';
import 'modules/experts/pages/experts_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meet our Experts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC084FC)),
        useMaterial3: true,
      ),
      home: const ExpertsPage(),
    );
  }
}
