import 'package:flutter/material.dart'; // Importing Flutter material design package
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firebase Firestore package
import 'package:kultura/screens/courses/resource_center.dart'; // Importing resource center page
import 'music_course.dart'; // Importing music course page
import 'literature_course.dart'; // Importing literature course page
import 'painting_course.dart'; // Importing painting course page

// Main screen for displaying course content
class CourseContentScreen extends StatelessWidget {
  const CourseContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'KULTURA',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
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

class CourseCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const CourseCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
