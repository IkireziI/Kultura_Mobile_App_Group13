import 'package:flutter/material.dart';
import 'package:kultura/config/styles_constant.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Image.asset(
                'assets/kultura.png',
                height: 40,
            ),
        ),
    );
  }
}

