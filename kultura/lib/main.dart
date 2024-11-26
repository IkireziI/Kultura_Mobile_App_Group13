import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kultura/firebase_options.dart';
import 'package:kultura/screens/courses/resource_center.dart';

// Importing screens
import 'package:kultura/screens/home.dart';
import 'package:kultura/screens/log_in.dart';
import 'package:kultura/screens/opportunities_board.dart' as opportunities;
import 'package:kultura/screens/sign_up.dart';
import 'package:kultura/screens/profile.dart';
import 'package:kultura/screens/marketplace.dart';
import 'package:kultura/screens/market_music.dart';
import 'package:kultura/screens/market_literature.dart';
import 'package:kultura/screens/profile_setting.dart';
import 'package:kultura/screens/search_page.dart';
import 'package:kultura/screens/courses/music_course.dart';
import 'package:kultura/screens/courses/painting_course.dart';
import 'package:kultura/screens/courses/literature_course.dart';
import 'package:kultura/screens/paintings_opportunities.dart';
import 'package:kultura/screens/literature_opportunities.dart';
import 'package:provider/provider.dart';
import 'screens/provider.dart';

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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginScreenProvider()),
        ChangeNotifierProvider(create: (_) => SignUpScreenProvider()),
        // Add more providers here if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kultura App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/login',
      routes: {
        // Authentication routes
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),

        // Home
        '/home': (context) => const Home(),

        // Marketplace routes
        '/marketplace': (context) => const MarketplacePage(),
        '/market_music': (context) => const MarketplaceMusic(),
        '/market_literature': (context) => const MarketplaceLiterature(),

        // Resource center and courses
        '/resource_center': (context) => const ArtisticCourseScreen(),
        '/music': (context) => const MusicCourseScreen(),
        '/painting': (context) => const PaintingCourseScreen(),
        '/literature': (context) => const LiteratureCourseScreen(),

        // Opportunities board
        '/opportunities_board': (context) => const opportunities.OpportunitiesBoard(),
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
