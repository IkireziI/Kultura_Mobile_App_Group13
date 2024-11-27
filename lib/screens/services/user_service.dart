// Browse Courses - Users can fetch courses filtered by category
// Track Progress - Save progress for each course (e.g., 50% watched)
// View History - Fetch the list of watched courses for the user

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

class UserService {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  final Logger _logger = Logger('UserService'); // Initialize the logger

  Future<void> saveProgress(
      String userId, String courseId, double progress) async {
    try {
      DocumentReference userDoc = _usersCollection.doc(userId);
      await userDoc.set(
          {
            'progress': {courseId: progress}
          },
          SetOptions(
              merge:
                  true)); // Merge progress data without overwriting existing data
      _logger.info('Progress for user $userId saved successfully');
    } catch (e) {
      _logger.severe('Error saving progress for user $userId: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchUserHistory(String userId) async {
    try {
      DocumentSnapshot userDoc = await _usersCollection.doc(userId).get();
      List<String> watchedCourses =
          (userDoc['watchedCourses'] ?? []) as List<String>;

      List<Map<String, dynamic>> history = [];
      for (String courseId in watchedCourses) {
        DocumentSnapshot courseDoc = await FirebaseFirestore.instance
            .collection('courses')
            .doc(courseId)
            .get();
        history.add(courseDoc.data() as Map<String, dynamic>);
      }
      _logger.info('User $userId history fetched successfully');
      return history;
    } catch (e) {
      _logger.severe('Error fetching history for user $userId: $e');
      rethrow;
    }
  }
}

void main() {
  UserService userService = UserService();

  // Sample data for a user's progress
  String userId = 'user123';
  String courseId = 'course456';
  double progress = 50.0; // 50% watched

  // Call the method to save progress
  userService.saveProgress(userId, courseId, progress).then((_) {
    // Success will be logged by the logger inside the service
  }).catchError((e) {
    // Errors will be logged by the logger inside the service
  });
}
