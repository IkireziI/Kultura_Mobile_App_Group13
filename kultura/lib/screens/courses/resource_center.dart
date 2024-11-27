// Resource Center Screen

import 'package:flutter/material.dart';

class ArtisticCourseScreen extends StatelessWidget {
  const ArtisticCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Artistic Course Header (replacing the second AppBar)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Artistic Course',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    tooltip: 'View History', // Tooltip message
                    icon: const Icon(
                      Icons.history_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/course_history');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16), // Spacing between header and cards
              // Course Cards
              CourseCard(
                title: 'Music',
                imageUrl: 'assets/images/music.png',
                backgroundColor: const Color(0xFFFCE4EC),
                imageHeight: 120,
                onTap: () {
                  Navigator.pushNamed(context, '/music');
                },
              ),
              const SizedBox(height: 28),
              CourseCard(
                title: 'Painting',
                imageUrl: 'assets/images/painting.png',
                backgroundColor: const Color(0xFFFCE4EC),
                imageHeight: 120,
                onTap: () {
                  Navigator.pushNamed(context, '/painting');
                },
              ),
              const SizedBox(height: 28),
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
    );
  }
}

// CourseCard Widget (unchanged)
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
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: double.infinity,
                  height: imageHeight,
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
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
// class BottomNavigation extends StatefulWidget {
//   final int selectedIndex; // Tracks the currently selected tab

//   const BottomNavigation({super.key, required this.selectedIndex});

//   @override
//   State<BottomNavigation> createState() => _BottomNavigationState();
// }

// class _BottomNavigationState extends State<BottomNavigation> {
//   late int _selectedIndex;

//   @override
//   void initState() {
//     super.initState();
//     _selectedIndex = widget.selectedIndex; // Sets the initial selected tab
//   }

//   // Handles tap events for each navigation item
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     switch (index) {
//       case 0:
//         Navigator.pushReplacementNamed(context, '/home'); // Navigates to Home
//         break;
//       case 1:
//         Navigator.pushReplacementNamed(
//             context, '/resource_center'); // Navigates to Resource Center
//         break;
//       case 2:
//         Navigator.pushReplacementNamed(
//             context, '/search'); // Navigates to Search Screen
//         break;
//       case 3:
//         Navigator.pushReplacementNamed(context,
//             '/opportunities_board'); // Navigates to Opportunities board
//         break;
//       case 4:
//         Navigator.pushReplacementNamed(
//             context, '/profile'); // Navigates to Profile Screen
//         break;
//       default:
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: _selectedIndex, // Highlights the selected tab
//       type: BottomNavigationBarType.fixed, // Fixed tab type
//       selectedItemColor: Colors.purple, // Selected icon color
//       unselectedItemColor: Colors.grey, // Unselected icon color
//       showSelectedLabels: false, // Hides selected labels
//       showUnselectedLabels: false, // Hides unselected labels
//       iconSize: 30, // Sets icon size
//       onTap: _onItemTapped, // Triggers _onItemTapped on tap
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home_outlined),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.auto_stories_outlined),
//           label: 'Resource Center',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.search_outlined),
//           label: 'Search',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.language_outlined),
//           label: 'Opportunities Board',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.account_circle_outlined),
//           label: 'Profile',
//         ),
//       ],
//     );
//   }
// }
