import 'package:flutter/material.dart';
import 'pages/opportunities_board.dart'; // Import your file containing OpportunitiesBoard widget

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
      home: const OpportunitiesBoard(), // Set OpportunitiesBoard as the home page
    );
  }
}
