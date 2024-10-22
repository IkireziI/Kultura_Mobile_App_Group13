import 'package:flutter/material.dart';
import 'package:kultura/pages/resource_center.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kultura App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/resource_center',
      routes: {
        '/resource_center': (context) => const ArtisticCourseScreen(),
      },
    );
  }
}
