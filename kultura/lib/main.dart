import 'package:flutter/material.dart';
import 'package:kultura/pages/resource_center.dart';
import 'package:kultura/pages/course_content.dart' as course_content;
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
      initialRoute: '/resource_center',
      routes: {
        '/resource_center': (context) => const ArtisticCourseScreen(),
        '/course_content': (context) => const course_content.CourseContentScreen(courseTitle: 'All Courses',),
        '/music': (context) => const MusicCourseScreen(),
        '/painting': (context) => const PaintingCourseScreen(),
        '/literature': (context) => const LiteratureCourseScreen(),
      },
    );
  }
}
