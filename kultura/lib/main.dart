import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kultura/firebase_options.dart';
import 'package:kultura/screens/home.dart';
import 'package:kultura/screens/log_in.dart';
import 'package:kultura/screens/opportunities_board.dart' as opportunities;
import 'package:kultura/screens/resource_center.dart' as resources;
import 'package:kultura/screens/sign_up.dart';
import 'screens/music_course.dart';
import 'screens/painting_course.dart';
import 'screens/literature_course.dart';
import 'screens/profile.dart';
import 'screens/marketplace.dart';
import 'screens/market_music.dart';
import 'screens/market_literature.dart';
import 'screens/profile_setting.dart';
import 'screens/search_page.dart';
import 'screens/paintings_opportunities.dart';
import 'screens/literature_opportunities.dart';

// Entry point of the application
Future<void> main() async {
  // initialise firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
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
      initialRoute: '/login',
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
        '/paintings_opportunities': (context) => const PaintingOpportunities(),
        '/literature_opportunities': (context) => const LiteratureOpportunities(),

        '/profile': (context) => const Profile(), // Route for the Profile Screen
        '/profile_setting': (context) => const ProfileSettingsScreen(), // Route for the Profile Settings Screen
        '/search': (context) => const SearchScreen(), // Route for the Search Screen
      },
    );
  }
}
