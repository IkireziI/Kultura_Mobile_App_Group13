import 'package:flutter/material.dart';
import 'package:kultura/pages/home.dart';
import 'package:kultura/pages/log_in.dart';
import 'package:kultura/pages/opportunities_board.dart' as opportunities;
import 'package:kultura/pages/resource_center.dart' as resources;
import 'package:kultura/pages/sign_up.dart';
import 'pages/music_course.dart';
import 'pages/painting_course.dart';
import 'pages/literature_course.dart';
import 'pages/profile.dart';
import 'pages/marketplace.dart';
import 'pages/market_music.dart';
import 'pages/market_literature.dart';
import 'pages/profile_setting.dart';
import 'pages/search_page.dart';

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
      title: 'Kultura App',
      debugShowCheckedModeBanner: false,// The title of the application
      theme: ThemeData(
        primarySwatch: Colors.purple, // Set the primary color theme to purple
      ),
      initialRoute: '/home', // Set the initial route to home
      routes: {
        // Authentication routes
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),

        '/home': (context) => const Home(), // Route for the home screen

        '/marketplace': (context) => const MarketplacePage(), // Route for the Marketplace (Painting)
        'market_music': (context) => const MarketplaceMusic(), // Route for the Marketplace (Music)
        'market_literature': (context) => const MarketplaceLiterature(), // Route for the Marketplace (Literature)
        '/resource_center': (context) =>
            const resources.ArtisticCourseScreen(), // Route for the resource center
        '/music': (context) =>
            const MusicCourseScreen(), // Route for the music course
        '/painting': (context) =>
            const PaintingCourseScreen(), // Route for the painting course
        '/literature': (context) =>
            const LiteratureCourseScreen(), // Route for the literature course
        '/opportunities_board': (context) =>
            const opportunities.OpportunitiesBoard(), // Route for the Opportunities board
        '/profile': (context) => const Profile(), // Route for the Profile Screen
        '/profile_setting': (context) => const ProfileSettingsScreen(), // Route for the Profile Settings Screen
        '/search': (context) => const SearchScreen(), // Route for the Search Screen
      },
    );
  }
}
