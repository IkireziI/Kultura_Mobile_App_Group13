import 'package:flutter/material.dart';
import 'package:kultura/pages/resource_center.dart';
import 'pages/music_course.dart';
import 'pages/painting_course.dart';
import 'pages/literature_course.dart';

// Entry point of the application
void main() {
  runApp(const MyApp()); // Run the MyApp widget
}

// MyApp class, which is a StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kultura App', // The title of the application
      theme: ThemeData(
        primarySwatch: Colors.purple, // Set the primary color theme to purple
      ),
      initialRoute: '/home', // Set the initial route to home
      routes: {
        // Define the application's routes
        '/home': (context) => const HomeScreen(), // Route for the home screen
        '/resource_center': (context) =>
            const ArtisticCourseScreen(), // Route for the resource center
        '/music': (context) =>
            const MusicCourseScreen(), // Route for the music course
        '/painting': (context) =>
            const PaintingCourseScreen(), // Route for the painting course
        '/literature': (context) =>
            const LiteratureCourseScreen(), // Route for the literature course
      },
    );
  }
}

// HomeScreen class, which is a StatelessWidget
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Disable the back button in the app bar
        title: const Text('Home'), // Title of the app bar
      ),
      body: const Center(
        child: Text('Home Screen Content'), // Centered text in the body
      ),
      bottomNavigationBar: const BottomNavigation(
          selectedIndex: 0), // Bottom navigation bar with selected index
    );
  }
}
