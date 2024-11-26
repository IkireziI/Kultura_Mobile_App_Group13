import 'package:flutter/material.dart'; // Importing Flutter material design package
import 'resource_center.dart'; // Importing resource center page
import 'music_course.dart'; // Importing music course page
import 'literature_course.dart'; // Importing literature course page
import 'painting_course.dart'; // Importing painting course page

// Main screen for displaying course content
class CourseContentScreen extends StatelessWidget {
  // Constructor for the CourseContentScreen, requires a course title
  const CourseContentScreen({super.key, required String courseTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color of the scaffold
      appBar: AppBar(
        title: const Text(
          'KULTURA', // Title of the app
          style: TextStyle(
            color: Colors.white, // Text color
            fontSize: 24, // Text size
            fontWeight: FontWeight.bold, // Text weight
          ),
        ),
        backgroundColor: Colors.purple, // App bar background color
        elevation: 0, // No shadow for app bar
      ),
      body: SingleChildScrollView(
        // Enables scrolling for the body
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding around the column
          child: Column(
            children: [
              // Music Course
              CourseCard(
                title: 'Music Course', // Title of the course
                description:
                    'Learn about music theory, composition, and instruments.', // Description of the course
                onTap: () {
                  // Navigate to Music Course Page when tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MusicCourseScreen()),
                  );
                },
              ),
              const SizedBox(height: 16), // Spacer between course cards

              // Literature Course
              CourseCard(
                title: 'Literature Course', // Title of the course
                description:
                    'Explore the world of literature, poetry, and storytelling.', // Description of the course
                onTap: () {
                  // Navigate to Literature Course Page when tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LiteratureCourseScreen()),
                  );
                },
              ),
              const SizedBox(height: 16), // Spacer between course cards

              // Painting Course
              CourseCard(
                title: 'Painting Course', // Title of the course
                description:
                    'Dive into painting techniques, styles, and art history.', // Description of the course
                onTap: () {
                  // Navigate to Painting Course Page when tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaintingCourseScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(
          selectedIndex: 1), // Bottom Navigation bar with selected index
    );
  }
}

// CourseCard Widget to Display Course Information
class CourseCard extends StatelessWidget {
  final String title; // Title of the course
  final String description; // Description of the course
  final VoidCallback onTap; // Function to call when the card is tapped

  const CourseCard({
    super.key,
    required this.title, // Required title parameter
    required this.description, // Required description parameter
    required this.onTap, // Required onTap callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger onTap function when the card is tapped
      child: Card(
        elevation: 4, // Elevation/shadow effect for the card
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Rounded corners for the card
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding inside the card
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align children to start
            children: [
              // Course title
              Text(
                title, // Display course title
                style: const TextStyle(
                  fontSize: 18, // Title font size
                  fontWeight: FontWeight.bold, // Title font weight
                ),
              ),
              const SizedBox(height: 8), // Spacer between title and description
              // Course description
              Text(
                description, // Display course description
                style: const TextStyle(
                    fontSize: 14, color: Colors.grey), // Description style
              ),
            ],
          ),
        ),
      ),
    );
  }
}
