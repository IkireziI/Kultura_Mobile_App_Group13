// Admin CRUD for courses (fetching, adding, deleting, etc.)
// Add Course - upload a course by providing its title, description, video URL, and category
// Update/Delete Course - modify or delete any existing course

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

class CourseService {
  final CollectionReference _coursesCollection =
      FirebaseFirestore.instance.collection('courses');

  final Logger _logger = Logger('CourseService'); // Initialize the logger

  Future<List<Map<String, dynamic>>> fetchCoursesByCategory(
      String category) async {
    try {
      QuerySnapshot querySnapshot =
          await _coursesCollection.where('category', isEqualTo: category).get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      _logger.severe('Failed to fetch courses by category: $e');
      rethrow; // Rethrow the error to be handled elsewhere if necessary
    }
  }

  Future<void> addCourse(Map<String, dynamic> courseData) async {
    try {
      await _coursesCollection.add(courseData); // Adds a new course
      _logger.info('Course added successfully');
    } catch (e) {
      _logger.severe('Error adding course: $e');
      rethrow;
    }
  }

  Future<void> deleteCourse(String courseId) async {
    try {
      await _coursesCollection.doc(courseId).delete(); // Deletes the course
      _logger.info('Course deleted successfully');
    } catch (e) {
      _logger.severe('Error deleting course: $e');
      rethrow;
    }
  }
}

void main() {
  CourseService courseService = CourseService();

  // Sample course data to trigger collection creation
  Map<String, dynamic> newCourse = {
    'title': 'Intro to Flutter',
    'description': 'A beginner-friendly course on Flutter.',
    'videoURL': 'http://example.com/video',
    'category': 'programming'
  };

  // Call the method to add the course
  courseService.addCourse(newCourse).then((_) {
    // Success will be logged by the logger inside the service
  }).catchError((e) {
    // Errors will be logged by the logger inside the service
  });
}
