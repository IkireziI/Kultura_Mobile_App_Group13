import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kultura/firebase_options.dart';
import "package:cloud_firestore/cloud_firestore.dart";

// Importing screens
import 'package:kultura/screens/home.dart';
import 'package:kultura/screens/log_in.dart';
import 'package:kultura/screens/reset_password.dart';
import 'package:kultura/screens/sign_up.dart';
import 'package:kultura/screens/profile.dart';
import 'package:kultura/screens/marketplace.dart';
import 'package:kultura/screens/market_music.dart';
import 'package:kultura/screens/market_literature.dart';
import 'package:kultura/screens/profile_setting.dart';
import 'package:kultura/screens/search_page.dart';
import 'package:kultura/screens/opportunities_board.dart' as opportunities;
import 'package:kultura/screens/courses/resource_center.dart' as resources;
import 'package:kultura/screens/courses/music_course.dart';
import 'package:kultura/screens/courses/painting_course.dart';
import 'package:kultura/screens/courses/literature_course.dart';
import 'package:kultura/screens/paintings_opportunities.dart';
import 'package:kultura/screens/literature_opportunities.dart';

Future<void> main() async {
  // Ensures widgets and Firebase are initialized
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint("Firebase successfully initialized.");
  } catch (e) {
    debugPrint("Error initializing Firebase: $e");
  }

  runApp(const MyApp()); // Runs the app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kultura App',
      debugShowCheckedModeBanner: false, // Removes debug banner
      theme: ThemeData(
        primarySwatch: Colors.purple, // Sets the primary color theme to purple
      ),
      initialRoute: '/login', // Default initial route
      routes: {
        // Authentication routes
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/signup': (context) => const SignUpScreen(),

        // Home
        '/home': (context) => const Home(),

        // Marketplace routes
        '/marketplace': (context) => const MarketplacePage(),
        '/market_music': (context) => const MarketplaceMusic(),
        '/market_literature': (context) => const MarketplaceLiterature(),

        // Resource center and courses
        '/resource_center': (context) => const resources.ArtisticCourseScreen(),
        '/music': (context) => const MusicCourseScreen(),
        '/painting': (context) => const PaintingCourseScreen(),
        '/literature': (context) => const LiteratureCourseScreen(),

        // Opportunities board
        '/opportunities_board': (context) =>
            const opportunities.OpportunitiesBoard(),
        '/paintings_opportunities': (context) => const PaintingOpportunities(),
        '/literature_opportunities': (context) =>
            const LiteratureOpportunities(),

        // Profile and settings
        '/profile': (context) => const Profile(),
        '/profile_setting': (context) => const ProfileSettingsScreen(),

        // Search
        '/search': (context) => const SearchScreen(),
      },
    );
  }
}
