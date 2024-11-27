class Artwork {
  final String id;
  final String title;
  final String price;
  final String imageUrl;
  final String category;

  Artwork({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
    };
  }
}
