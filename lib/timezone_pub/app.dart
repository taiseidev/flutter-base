import 'package:flutter/material.dart';
import 'package:flutter_base/timezone_pub/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'timezone pub',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: TimeZoneSample(),
    );
  }
}
