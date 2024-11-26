import 'package:cloud_firestore/cloud_firestore.dart';

class JobOpportunitiesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addOpportunity({
    required String title, 
    required String category, 
    required String location, 
    required String description, 
    required String createdBy
  }) async {
    // Input validation
    if (title.isEmpty || category.isEmpty || location.isEmpty || description.isEmpty) {
      throw ArgumentError('All fields must be filled');
    }

    try {
      CollectionReference opportunities = _firestore.collection('opportunities_board');
      await opportunities.add({
        'title': title,
        'category': category,
        'location': location,
        'description': description,
        'createdBy': createdBy,
        'applicants': [],
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Better error handling
      throw Exception('Failed to add opportunity: $e');
    }
  }

  Stream<QuerySnapshot> fetchOpportunitiesByCategory(String category) {
    return _firestore
        .collection('opportunities_board')
        .where('category', isEqualTo: category)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> applyForJob(String jobId, String userId) async {
    if (jobId.isEmpty || userId.isEmpty) {
      throw ArgumentError('Job ID and User ID cannot be empty');
    }

    try {
      DocumentReference jobRef = _firestore.collection('opportunities_board').doc(jobId);

      await jobRef.update({
        'applicants': FieldValue.arrayUnion([userId]),
      });
    } catch (e) {
      throw Exception('Error applying for job: $e');
    }
  }

  Future<void> deleteOpportunity(String docId) async {
    if (docId.isEmpty) {
      throw ArgumentError('Document ID cannot be empty');
    }

    try {
      await _firestore.collection('opportunities_board').doc(docId).delete();
    } catch (e) {
      throw Exception('Failed to delete opportunity: $e');
    }
  }
}