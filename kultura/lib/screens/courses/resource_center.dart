// Resource Center Screen

import 'package:flutter/material.dart';

// Defines the ArtisticCourseScreen as a stateless widget
class ArtisticCourseScreen extends StatelessWidget {
  const ArtisticCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Sets the screen background color to white
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hides the back button
        title: const Text(
          'Artistic Course', // Sets the title of the app bar
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white, // Makes the app bar background white
        elevation: 0, // Removes the app bar shadow
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
              16.0), // Adds padding around the body content
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Aligns content to the left
            children: [
              // CourseCard for Music course
              CourseCard(
                title: 'Music',
                imageUrl: 'assets/images/music.png',
                backgroundColor:
                    const Color(0xFFFCE4EC), // Background color for card
                imageHeight: 120, // Sets image height
                onTap: () {
                  Navigator.pushNamed(
                      context, '/music'); // Navigates to Music page
                },
              ),
              const SizedBox(height: 28), // Space between cards
              // CourseCard for Painting course
              CourseCard(
                title: 'Painting',
                imageUrl: 'assets/images/painting.png',
                backgroundColor: const Color(0xFFFCE4EC),
                imageHeight: 120,
                onTap: () {
                  Navigator.pushNamed(
                      context, '/painting'); // Navigates to Painting page
                },
              ),
              const SizedBox(height: 28), // Space between cards
              // CourseCard for Literature course
              CourseCard(
                title: 'Literature',
                imageUrl: 'assets/images/literature.png',
                backgroundColor: const Color(0xFFFCE4EC),
                imageHeight: 120,
                onTap: () {
                  Navigator.pushNamed(
                      context, '/literature'); // Navigates to Literature page
                },
              ),
            ],
          ),
        ),
      ),
      // Adds the bottom navigation bar to the screen
      bottomNavigationBar: const BottomNavigation(selectedIndex: 1),
    );
  }
}

// Custom widget for each course card
class CourseCard extends StatelessWidget {
  final String title; // Course title
  final String imageUrl; // Path to the course image
  final Color backgroundColor; // Background color for the card
  final double imageHeight; // Image height
  final VoidCallback onTap; // Callback function when tapped

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
      onTap: onTap, // Triggers the onTap callback when tapped
      child: Container(
        width: double.infinity, // Makes the card take full width
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20), // Rounds the card corners
        ),
        clipBehavior: Clip.antiAlias, // Clips overflowed content
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Aligns content to the left
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  16, 16, 16, 0), // Padding around the image
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(12), // Rounds the image corners
                child: SizedBox(
                  width: double.infinity,
                  height: imageHeight, // Sets image height
                  child: Image.asset(
                    imageUrl, // Loads the image asset
                    fit: BoxFit.cover, // Fills the image to cover the container
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0), // Padding around the title
              child: Text(
                title, // Displays the course title
                style: const TextStyle(
                  fontSize: 22,
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

// Bottom navigation bar widget with 5 items
class BottomNavigation extends StatefulWidget {
  final int selectedIndex; // Tracks the currently selected tab

  const BottomNavigation({super.key, required this.selectedIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex; // Sets the initial selected tab
  }

  // Handles tap events for each navigation item
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home'); // Navigates to Home
        break;
      case 1:
        Navigator.pushReplacementNamed(
            context, '/resource_center'); // Navigates to Resource Center
        break;
      case 2:
        Navigator.pushReplacementNamed(
            context, '/search'); // Navigates to Search Screen
        break;
      case 3:
        Navigator.pushReplacementNamed(context,
            '/opportunities_board'); // Navigates to Opportunities board
        break;
      case 4:
        Navigator.pushReplacementNamed(
            context, '/profile'); // Navigates to Profile Screen
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex, // Highlights the selected tab
      type: BottomNavigationBarType.fixed, // Fixed tab type
      selectedItemColor: Colors.purple, // Selected icon color
      unselectedItemColor: Colors.grey, // Unselected icon color
      showSelectedLabels: false, // Hides selected labels
      showUnselectedLabels: false, // Hides unselected labels
      iconSize: 30, // Sets icon size
      onTap: _onItemTapped, // Triggers _onItemTapped on tap
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
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
          label: 'Opportunities Board',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}
