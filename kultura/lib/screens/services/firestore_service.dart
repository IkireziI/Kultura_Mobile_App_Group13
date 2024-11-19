import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final Logger _logger = Logger(); // Initialize the logger instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a course in Firestore
  Future<void> createCourse(
      String courseId, Map<String, dynamic> courseData) async {
    try {
      await _firestore.collection('courses').doc(courseId).set(courseData);
      _logger.i(
          'Course created successfully: $courseId'); // Log informational message
    } catch (e) {
      _logger.e('Error creating course: $courseId',
          error: e); // Log error message
    }
  }

  // Update an existing course in Firestore
  Future<void> updateCourse(
      String courseId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('courses').doc(courseId).update(updates);
      _logger.i(
          'Course updated successfully: $courseId'); // Log informational message
    } catch (e) {
      _logger.e('Error updating course: $courseId',
          error: e); // Log error message
    }
  }

  // Delete a course from Firestore
  Future<void> deleteCourse(String courseId) async {
    try {
      await _firestore.collection('courses').doc(courseId).delete();
      _logger.i(
          'Course deleted successfully: $courseId'); // Log informational message
    } catch (e) {
      _logger.e('Error deleting course: $courseId',
          error: e); // Log error message
    }
  }

  // Fetch a course from Firestore
  Future<Map<String, dynamic>?> getCourse(String courseId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('courses').doc(courseId).get();
      if (snapshot.exists) {
        _logger.i('Course fetched successfully: $courseId');
        return snapshot.data();
      } else {
        _logger
            .w('Course not found: $courseId'); // Warning if no course is found
        return null;
      }
    } catch (e) {
      _logger.e('Error fetching course: $courseId',
          error: e); // Log error message
      return null;
    }
  }

  // Batch setup for multiple courses
  Future<void> setupCourses() async {
    try {
      final batch = _firestore.batch();
      final courses = [
        {
          'course_id': 'music',
          'title': 'Music Course',
          'description': 'Learn music theory and practice.',
        },
        {
          'course_id': 'literature',
          'title': 'Literature Course',
          'description': 'Dive into the world of prose and poetry.',
        },
        {
          'course_id': 'painting',
          'title': 'Painting Course',
          'description': 'Explore painting techniques and history.',
        },
      ];

      for (var course in courses) {
        final docRef =
            _firestore.collection('courses').doc(course['course_id']);
        batch.set(docRef, course);
      }

      await batch.commit();
      _logger.i('All courses set up successfully!');
    } catch (e) {
      _logger.e('Error setting up courses', error: e); // Log error message
    }
  }
}
