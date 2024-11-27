import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  final List<Course> _courses = [
    Course(
      title: 'Paint ANYTHING in just 4 Simple Steps!',
      videoUrl: 'https://youtu.be/rcfMSeilPkg?si=2FGH7DpHzXazyz2u',
      progress: 0.75,
    ),
    Course(
      title: '50 Easy Acrylic Painting Ideas for Beginners',
      videoUrl: 'https://youtu.be/UO1qql_4WSA?si=8KpzdZHCs7PZJV0H',
      progress: 0.3,
    ),
  ];

  Widget _buildCourseCard(Course course) {
    return Card(
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
              course.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: course.progress,
              color: Colors.purple,
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 8),
            Text(
              '${(course.progress * 100).toInt()}% Complete',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Matches AppBar background
      extendBodyBehindAppBar: true, // Ensures gradient starts from top
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent, // Transparent AppBar
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/KULTURA.png',
                  height: 40,
                ),
              ),
            ),
            const IconButton(
              icon: Icon(null),
              onPressed: null,
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF9C27B0),
              Color(0xFFE1BEE7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Add a SizedBox to prevent the search bar from overlapping with the AppBar
            const SizedBox(
                height: kToolbarHeight + 66), // Accounts for AppBar height
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.8), // Semi-transparent background
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.black),
                      onPressed: () {
                        // Handle filter action (functionality to be implemented)
                      },
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16), // Space between search bar and list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _courses.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return _buildCourseCard(_courses[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Course model
class Course {
  final String title;
  final String videoUrl;
  double progress;

  Course({
    required this.title,
    required this.videoUrl,
    required this.progress,
  });
}
