import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({Key? key}) : super(key: key);

  @override
  _MarketplacePageState createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  final List<String> _categories = ["All", "Paintings", "Sculptures", "Music", "Literature"];
  String _selectedCategory = "All";
  int _selectedIndex = 0;
  final String _userId = "sampleUserId"; // Replace with real user ID logic

  // Fetch wishlist state for a specific artwork
  Future<bool> _iswishlistd(String artworkId) async {
    final doc = await FirebaseFirestore.instance
        .collection('wishlists')
        .doc('$_userId-$artworkId')
        .get();
    return doc.exists;
  }

  // Toggle wishlist state in Firestore
  Future<void> _togglewishlist(String artworkId) async {
    final wishlistDoc = FirebaseFirestore.instance
        .collection('wishlists')
        .doc('$_userId-$artworkId');

    final docSnapshot = await wishlistDoc.get();
    if (docSnapshot.exists) {
      // If already wishlistd, remove it
      await wishlistDoc.delete();
    } else {
      // Add to wishlists
      await wishlistDoc.set({
        'userId': _userId,
        'artworkId': artworkId,
        'wishlistdAt': Timestamp.now(),
      });
    }

    setState(() {}); // Trigger UI update
  }

  // Navigation logic for the bottom navigation bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to respective screens based on the index
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/resource_center');
        break;
      case 2:
        Navigator.pushNamed(context, '/search');
        break;
      case 3:
        Navigator.pushNamed(context, '/opportunities_board');
        break;
      case 4:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Marketplace"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Category filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: FilterChip(
                      label: Text(category),
                      selected: _selectedCategory == category,
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedCategory = selected ? category : "All";
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            // Display artworks
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _selectedCategory == "All"
                    ? FirebaseFirestore.instance.collection('artworks').snapshots()
                    : FirebaseFirestore.instance
                        .collection('artworks')
                        .where('category', isEqualTo: _selectedCategory)
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No artworks available"));
                  }

                  final artworks = snapshot.data!.docs;
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: artworks.length,
                    itemBuilder: (context, index) {
                      final artwork = artworks[index];
                      final artworkId = artwork.id;
                      final artworkTitle = artwork['title'];
                      final artworkImageUrl = artwork['imageUrl'];
                      final artworkPrice = artwork['price'];

                      return Card(
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.network(
                                artworkImageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 50),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    artworkTitle,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "\$${artworkPrice}",
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                  FutureBuilder<bool>(
                                    future: _iswishlistd(artworkId),
                                    builder: (context, snapshot) {
                                      final iswishlistd = snapshot.data ?? false;
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              iswishlistd
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color:
                                                  iswishlistd ? Colors.purple : Colors.grey,
                                            ),
                                            onPressed: () => _togglewishlist(artworkId),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  title: const Text("Buy Artwork"),
                                                  content: Text(
                                                      "Do you want to purchase '$artworkTitle'?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context),
                                                      child: const Text("Cancel"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(context)
                                                            .showSnackBar(const SnackBar(
                                                                content: Text(
                                                                    "Purchase successful!")));
                                                      },
                                                      child: const Text("Buy"),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            child: const Text("Buy"),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create_artwork');
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories_outlined),
            label: 'Resource Center',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language_outlined),
            label: 'Opportunities Board',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}