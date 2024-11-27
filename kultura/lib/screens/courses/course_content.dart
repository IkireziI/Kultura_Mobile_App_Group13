import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; // Importing Flutter material design package
// Importing resource center page
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
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: FutureBuilder<QuerySnapshot>(
        // Fetch courses from Firestore
        future: FirebaseFirestore.instance.collection('courses').get(),
        builder: (context, snapshot) {
          // Check if data is loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Check for errors
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching courses. Please try again later.'),
            );
          }

          // If data is fetched successfully
          if (snapshot.hasData) {
            final courses = snapshot.data!.docs;

            // Display list of courses
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: courses.map((course) {
                    final courseData = course.data() as Map<String, dynamic>;

                    return Column(
                      children: [
                        CourseCard(
                          title: courseData['title'] ?? 'No Title',
                          description:
                              courseData['description'] ?? 'No Description',
                          onTap: () {
                            // Navigate to specific course page based on course ID
                            switch (courseData['course_id']) {
                              case 'music':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MusicCourseScreen()),
                                );
                                break;
                              case 'literature':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LiteratureCourseScreen()),
                                );
                                break;
                              case 'painting':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PaintingCourseScreen()),
                                );
                                break;
                              default:
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Course ${courseData['title']} is not yet available.'),
                                  ),
                                );
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          }

          // Handle empty state
          return const Center(child: Text('No courses available.'));
        },
      ),
      // bottomNavigationBar: const BottomNavigation(selectedIndex: 1),
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
