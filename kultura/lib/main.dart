import 'package:flutter/material.dart';
import 'package:kultura/pages/log_in.dart';
import 'pages/opportunities_board.dart';
import 'pages/sign_up.dart';
import 'pages/home.dart';

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
      initialRoute: '/login',

      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),

        '/home': (context) => const Home(),

        '/opportunities': (context) => const OpportunitiesBoard(),
      },

    );
  }
}
