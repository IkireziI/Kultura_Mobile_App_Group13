import 'package:flutter/material.dart';

// The main screen displaying the artistic courses available
class ArtisticCourseScreen extends StatelessWidget {
  const ArtisticCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color of the screen
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the default back button
        title: const Text(
          'Artistic Course', // Title of the app bar
          style: TextStyle(
            color: Colors.black, // Title text color
            fontSize: 24, // Title text size
            fontWeight: FontWeight.bold, // Title text weight
          ),
        ),
        backgroundColor: Colors.white, // App bar background color
        elevation: 0, // No shadow under the app bar
      ),
      body: SingleChildScrollView(
        // Allow scrolling for the body content
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding around the content
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align children to the start
            children: [
              // Card for the Music course
              CourseCard(
                title: 'Music', // Title of the course
                imageUrl: 'assets/images/music.png', // Path to the course image
                backgroundColor:
                    const Color(0xFFFCE4EC), // Background color of the card
                imageHeight: 120, // Height of the course image
                onTap: () {
                  // Navigate to the music course when tapped
                  Navigator.pushNamed(context, '/music');
                },
              ),
              const SizedBox(height: 32), // Space between course cards
              // Card for the Painting course
              CourseCard(
                title: 'Painting',
                imageUrl: 'assets/images/painting.png',
                backgroundColor: const Color(0xFFFCE4EC),
                imageHeight: 150,
                onTap: () {
                  // Navigate to the painting course when tapped
                  Navigator.pushNamed(context, '/painting');
                },
              ),
              const SizedBox(height: 32), // Space between course cards
              // Card for the Literature course
              CourseCard(
                title: 'Literature',
                imageUrl: 'assets/images/literature.png',
                backgroundColor: const Color(0xFFFCE4EC),
                imageHeight: 120,
                onTap: () {
                  // Navigate to the literature course when tapped
                  Navigator.pushNamed(context, '/literature');
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          const BottomNavigation(selectedIndex: 1), // Bottom navigation bar
    );
  }
}

// Widget representing an individual course card
class CourseCard extends StatelessWidget {
  final String title; // Course title
  final String imageUrl; // URL of the course image
  final Color backgroundColor; // Background color of the card
  final double imageHeight; // Height of the course image
  final VoidCallback onTap; // Callback function when the card is tapped

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
      onTap: onTap, // Trigger the onTap function when tapped
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor, // Set the background color
          borderRadius:
              BorderRadius.circular(20), // Rounded corners for the card
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to the start
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), // Rounded corner for the top left
                topRight:
                    Radius.circular(20), // Rounded corner for the top right
              ),
              child: Image.asset(
                imageUrl, // Load image from asset
                width: double.infinity, // Take full width of the container
                height: imageHeight, // Set the image height
                fit: BoxFit.cover, // Scale the image to cover the area
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0), // Padding around the text
              child: Text(
                title, // Display the course title
                style: const TextStyle(
                  fontSize: 24, // Font size of the title
                  fontWeight: FontWeight.bold, // Bold font weight
                  color: Colors.black, // Title text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Bottom navigation widget to switch between screens
class BottomNavigation extends StatefulWidget {
  final int selectedIndex; // Currently selected tab index

  const BottomNavigation({super.key, required this.selectedIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int _selectedIndex; // Variable to track selected index

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex; // Initialize selected index
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });
    // Navigate to the corresponding screen based on the tapped index
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home'); // Navigate to Home
        break;
      case 1:
        Navigator.pushReplacementNamed(
            context, '/resource_center'); // Navigate to Resource Center
        break;
      // Additional cases for other tabs if needed
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex, // Set the current index
      type: BottomNavigationBarType.fixed, // Fixed bottom navigation bar
      selectedItemColor: Colors.purple, // Color for selected item
      unselectedItemColor: Colors.grey, // Color for unselected items
      showSelectedLabels: false, // Hide labels for selected items
      showUnselectedLabels: false, // Hide labels for unselected items
      iconSize: 30, // Size of the icons
      onTap: _onItemTapped, // Function to call on item tap
      items: const [
        // Navigation bar items
        BottomNavigationBarItem(
          icon: Icon(Icons.add_home_outlined), // Icon for Home
          label: 'Home', // Label for Home
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_stories_outlined), // Icon for Resource Center
          label: 'Resource Center', // Label for Resource Center
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined), // Icon for Search
          label: 'Search', // Label for Search
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.language_outlined), // Icon for Marketplace
          label: 'Marketplace', // Label for Marketplace
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined), // Icon for Profile
          label: 'Profile', // Label for Profile
        ),
      ],
    );
  }
}
