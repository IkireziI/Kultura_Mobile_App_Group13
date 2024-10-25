import 'package:flutter/material.dart';
import 'package:kultura/pages/resource_center.dart';
import 'pages/music_course.dart';
import 'pages/painting_course.dart';
import 'pages/literature_course.dart';

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
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/resource_center': (context) => const ArtisticCourseScreen(),
        '/music': (context) => const MusicCourseScreen(),
        '/painting': (context) => const PaintingCourseScreen(),
        '/literature': (context) => const LiteratureCourseScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Home Screen Content'),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
