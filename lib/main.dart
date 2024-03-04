import 'package:flutter/material.dart';
import 'package:flutternewsapp_withapi/views/homepage.dart';

// 64b7496844ea48ae86a7d7548be8d502
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
