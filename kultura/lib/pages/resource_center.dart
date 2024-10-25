import 'package:flutter/material.dart';

class ArtisticCourseScreen extends StatelessWidget {
  const ArtisticCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Artistic Course',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CourseCard(
                title: 'Music',
                imageUrl: 'assets/images/music.png',
                backgroundColor: const Color(0xFFFCE4EC),
                imageHeight: 120,
                onTap: () {
                  Navigator.pushNamed(context, '/music');
                },
              ),
              const SizedBox(height: 32),
              CourseCard(
                title: 'Painting',
                imageUrl: 'assets/images/painting.png',
                backgroundColor: const Color(0xFFFCE4EC),
                imageHeight: 150,
                onTap: () {
                  Navigator.pushNamed(context, '/painting');
                },
              ),
              const SizedBox(height: 32),
              CourseCard(
                title: 'Literature',
                imageUrl: 'assets/images/literature.png',
                backgroundColor: const Color(0xFFFCE4EC),
                imageHeight: 120,
                onTap: () {
                  Navigator.pushNamed(context, '/literature');
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(selectedIndex: 1),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Color backgroundColor;
  final double imageHeight;
  final VoidCallback onTap;

  const CourseCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.backgroundColor,
    required this.imageHeight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.asset(
                imageUrl,
                width: double.infinity,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  final int selectedIndex;

  const BottomNavigation({super.key, required this.selectedIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/resource_center');
        break;
      // Additional cases for other tabs if needed
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 30,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.add_home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_stories_outlined),
          label: 'Resource Center',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.language_outlined),
          label: 'Marketplace',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}
