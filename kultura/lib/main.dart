import 'package:flutter/material.dart';
import 'package:kultura/pages/log_in.dart';
import 'pages/opportunities_board.dart';
import 'pages/sign_up.dart';
import 'pages/settings.dart';
import 'pages/profile_settings.dart';

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
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/opportunities': (context) => const OpportunitiesBoard(),
         '/profile_settings': (context) => const ProfileSettingsPage(),
      },
      home: const HomeScreen(),  // You need to specify a home screen
    );
  }
}

//nav bar to display all screens
//NB: this is used to be used before the home page arrives

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text('Opportunities'),
              onTap: () {
                Navigator.pop(context); // Close the drawer first
                if (ModalRoute.of(context)?.settings.name != '/opportunities') {
                  Navigator.popAndPushNamed(context, '/opportunities');
                }
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer first
                if (ModalRoute.of(context)?.settings.name != '/settings') {
                  Navigator.popAndPushNamed(context, '/settings');
                }
              },
            ),
            ListTile(
              title: const Text('Signup'),
              onTap: () {
                Navigator.pop(context); // Close the drawer first
                if (ModalRoute.of(context)?.settings.name != '/signup') {
                  Navigator.popAndPushNamed(context, '/signup');
                }
              },
            ),

             ListTile(
              title: const Text('ProfileSettings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer first
                if (ModalRoute.of(context)?.settings.name != '/profile_settings') {
                  Navigator.popAndPushNamed(context, '/profile_settings');
                }
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Welcome to the Kultura App'),
      ),
    );
  }
}
