import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kultura/screens/services/firestore_service.dart';

void main() {
  late FirebaseFirestore firestore;
  late FirestoreService firestoreService;

  group('Firestore Tests', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

      // Use Firestore Emulator
      firestore = FirebaseFirestore.instance;
      firestore.useFirestoreEmulator('localhost', 8081);

      // Initialize FirestoreService
      firestoreService = FirestoreService();
    });

    tearDownAll(() async {
      // Clean up Firestore test data after all tests
      final coursesSnapshot = await firestore.collection('courses').get();
      for (var doc in coursesSnapshot.docs) {
        await doc.reference.delete();
      }
    });

    // Test individual course creation using FirestoreService
    test('Add a course using FirestoreService', () async {
      // Arrange: Prepare test data
      const String courseId = 'test_course';
      final Map<String, dynamic> courseData = {
        'title': 'Test Course',
        'description': 'This is a test course description.',
      };

      // Act: Add the course using FirestoreService
      await firestoreService.createCourse(courseId, courseData);

      // Assert: Verify that the course was added correctly
      final addedCourse =
          await firestore.collection('courses').doc(courseId).get();
      expect(addedCourse.exists, true);
      expect(addedCourse.data()?['title'], courseData['title']);
      expect(addedCourse.data()?['description'], courseData['description']);
    });

    // Test batch setup of courses using FirestoreService
    test('Batch setup using FirestoreService', () async {
      // Act: Call the batch setup method
      await firestoreService.setupCourses();

      // Assert: Verify that at least the expected courses were added
      final coursesSnapshot = await firestore.collection('courses').get();
      expect(coursesSnapshot.docs.length, greaterThanOrEqualTo(3));

      // Optional: Verify specific course data if needed
      final musicCourse =
          await firestore.collection('courses').doc('music').get();
      expect(musicCourse.exists, true);
      expect(musicCourse.data()?['title'], 'Music Course');
    });
  });
}
