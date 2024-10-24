import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Image.asset(
                'assets/kultura.png',
                height: 40,
            ),
            backgroundColor: Colors.purple,
        ),

        body: HomePageContent(),
        // Body
        bottomNavigationBar: BottomNavigation(),
        // Bottom Navigation Bar
    );
  }
}

// HomePage Content
class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
            Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                                Colors.purple,
                                Color.fromARGB(255, 172, 48, 194),
                                Color.fromARGB(255, 202, 62, 226),
                                Color.fromARGB(255, 217, 100, 238),
                                Color.fromARGB(255, 212, 131, 226),
                            ]
                        ),
                    ),
                ), 
            ),
        ],
    );
  }
}

// Bottom Navigation bar widget
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        // Add your navigation logic here
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.add_home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.auto_stories_outlined), label: 'Resources'),
        BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.language_outlined), label: 'Opportunities'),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
      ],
    );
  }
}

