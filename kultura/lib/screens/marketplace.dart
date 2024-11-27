import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home.dart';

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

  // Form controllers for payment
  final _paymentFormKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

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

  // Show payment form
  void _showPaymentForm(BuildContext context, String artworkTitle) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Payment for '$artworkTitle'"),
          content: Form(
            key: _paymentFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Card Number",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your card number.";
                    }
                    if (value.length < 16) {
                      return "Card number must be 16 digits.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _expiryDateController,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    labelText: "Expiry Date (MM/YY)",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the expiry date.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _cvvController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "CVV",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the CVV.";
                    }
                    if (value.length != 3) {
                      return "CVV must be 3 digits.";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_paymentFormKey.currentState!.validate()) {
                  Navigator.pop(context); // Close the payment form dialog
                  _showSuccessAlert(context); // Show the success alert
                }
              },
              child: const Text("Pay"),
            ),
          ],
        );
      },
    );
  }

  // Show success alert
  void _showSuccessAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Color.fromARGB(255, 139, 18, 129), size: 60),
              const SizedBox(height: 20),
              const Text(
                "Paid!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Thank you for buying kultura's art!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      },
    );
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
                                    style: const TextStyle(color: Color.fromARGB(255, 117, 11, 133)),
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
                                                  iswishlistd ? const Color.fromARGB(255, 144, 8, 194) : Colors.grey,
                                            ),
                                            onPressed: () =>
                                                _togglewishlist(artworkId),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.shopping_cart),
                                            onPressed: () =>
                                                _showPaymentForm(context, artworkTitle),
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
      bottomNavigationBar: const BottomNavigation(selectedIndex: 3),
    );
  }
}
