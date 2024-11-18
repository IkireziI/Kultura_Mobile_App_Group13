class Portfolio {
  final String id; // Firestore document ID
  final String title;
  final String description;
  final String? imageUrl; // Optional URL of an uploaded image
  final String? uploadedFileUrl; // Optional URL of an additional uploaded file
  final DateTime createdAt;

  Portfolio({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl, // Optional
    this.uploadedFileUrl, // Optional
    required this.createdAt,
  });

  // Convert Portfolio to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'uploadedFileUrl': uploadedFileUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create Portfolio from Firestore document
  static Portfolio fromMap(String id, Map<String, dynamic> map) {
    return Portfolio(
      id: id,
      title: map['title'] ?? 'Untitled', // Default if `title` is missing
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'], // Nullable
      uploadedFileUrl: map['uploadedFileUrl'], // Nullable
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
