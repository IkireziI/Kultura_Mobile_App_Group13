import 'package:flutter/material.dart';

// Main function to start the app
void main() {
  runApp(const MyApp());
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artistic Course App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const ArtisticCourseScreen(),
    );
  }
}

// Artistic Course screen that displays course cards and bottom navigation bar
class ArtisticCourseScreen extends StatelessWidget {
  const ArtisticCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      // Scrollable body content
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Music course card
              CourseCard(
                title: 'Music',
                imageUrl: 'assets/images/music.png',
                backgroundColor: const Color(0xFFFCE4EC),
                imageHeight: 120,
                onTap: () {
                  // Navigate to course details
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const CourseContentScreen(courseTitle: 'Music')),
                  );
                },
              ),
              const SizedBox(height: 32), // Increased space between cards
              // Painting course card
              CourseCard(
                title: 'Painting',
                imageUrl: 'assets/images/painting.png',
                backgroundColor: const Color(0xFFFCE4EC),
                imageHeight: 150,
                onTap: () {
                  // Navigate to course details
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const CourseContentScreen(courseTitle: 'Painting')),
                  );
                },
              ),
              const SizedBox(height: 32), // Increased space between cards
              // Literature course card
              CourseCard(
                title: 'Literature',
                imageUrl: 'assets/images/literature.png',
                backgroundColor: const Color(0xFFFCE4EC),
                imageHeight: 120,
                onTap: () {
                  // Navigate to course details
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CourseContentScreen(
                            courseTitle: 'Literature')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      // Bottom navigation bar
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

// Course card widget that displays an image, title, and click functionality
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
      onTap: onTap, // Makes the entire card clickable
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

// Bottom Navigation bar widget
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 1; // Default index set to 1 (Stories)

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false, // Remove labels from selected items
      showUnselectedLabels: false, // Remove labels from unselected items
      iconSize: 30, // Increased icon size
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        // Navigation logic based on selected index
        if (index == 0) {
          // Navigate to Home (Resource Center Screen) with back arrow
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ResourceCenterScreen()),
          );
        } else if (index == 1) {
          // Navigate to ArtisticCourseScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ArtisticCourseScreen()),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.add_home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_stories_outlined),
          label: 'Stories', // Focused icon
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

// Placeholder screen for Resource Center
class ResourceCenterScreen extends StatelessWidget {
  const ResourceCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to previous screen
          },
        ),
        title: const Text('Resource Center'),
      ),
      body: const Center(
        child: Text('Resource Center Content'),
      ),
    );
  }
}

// Placeholder screen for course content
class CourseContentScreen extends StatelessWidget {
  final String courseTitle;

  const CourseContentScreen({super.key, required this.courseTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to previous screen
          },
        ),
      ),
      body: Center(
        child: Text('Content for $courseTitle course'),
      ),
    );
  }
}
