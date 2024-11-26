import 'package:cloud_firestore/cloud_firestore.dart';

class JobOpportunitiesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetch all opportunities
  Stream<QuerySnapshot> fetchAllOpportunities() {
    return _firestore.collection('opportunities_board').snapshots();
  }

  /// Fetch opportunities filtered by category
  Stream<QuerySnapshot> fetchOpportunitiesByCategory(String category) {
    return _firestore
        .collection('opportunities_board')
        .where('category', isEqualTo: category)
        .snapshots();
  }

  /// Add a new opportunity to Firestore
  Future<void> addOpportunity(Map<String, dynamic> opportunity) async {
    await _firestore.collection('opportunities_board').add(opportunity);
  }

  /// Update an existing opportunity in Firestore
  Future<void> updateOpportunity(String id, Map<String, dynamic> updatedData) async {
    await _firestore.collection('opportunities_board').doc(id).update(updatedData);
  }

  /// Delete an opportunity from Firestore
  Future<void> deleteOpportunity(String id) async {
    await _firestore.collection('opportunities_board').doc(id).delete();
  }

  /// Apply to an opportunity (example functionality)
  Future<void> applyToOpportunity(String opportunityId, String userId) async {
    final applicationRef = _firestore
        .collection('opportunities_board')
        .doc(opportunityId)
        .collection('applications')
        .doc(userId);

    await applicationRef.set({'appliedAt': DateTime.now()});
  }
}
