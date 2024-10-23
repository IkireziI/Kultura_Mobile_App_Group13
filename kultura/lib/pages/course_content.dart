import 'package:flutter/material.dart';
import 'package:kultura/pages/resource_center.dart';
import 'music_course.dart';
import 'literature_course.dart';
import 'painting_course.dart';

class CourseContentScreen extends StatelessWidget {
  const CourseContentScreen({super.key, required String courseTitle});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Music Course
              CourseCard(
                title: 'Music Course',
                description:
                    'Learn about music theory, composition, and instruments.',
                onTap: () {
                  // Navigate to Music Course Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MusicCourseScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Literature Course
              CourseCard(
                title: 'Literature Course',
                description:
                    'Explore the world of literature, poetry, and storytelling.',
                onTap: () {
                  // Navigate to Literature Course Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LiteratureCourseScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Painting Course
              CourseCard(
                title: 'Painting Course',
                description:
                    'Dive into painting techniques, styles, and art history.',
                onTap: () {
                  // Navigate to Painting Course Page
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
      bottomNavigationBar: const BottomNavigation(), // Bottom Navigation
    );
  }
}

// CourseCard Widget to Display Course Information
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
              // Course title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Course description
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
