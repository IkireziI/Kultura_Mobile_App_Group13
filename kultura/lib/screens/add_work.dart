import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'art_work.dart';

class AddArtworkPage extends StatefulWidget {
  const AddArtworkPage({super.key});

  @override
  State<AddArtworkPage> createState() => _AddArtworkPageState();
}

class _AddArtworkPageState extends State<AddArtworkPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();

  bool _isLoading = false; // Loading indicator state
  String? _selectedCategory; // Selected category

  // List of categories
  final List<String> _categories = ["Painting", "Sculpture", "Music", "Literature"];

  // Add Artwork Function
  void _addArtwork() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      try {
        // Create an Artwork object
        final artwork = Artwork(
          id: DateTime.now().millisecondsSinceEpoch.toString(), // Use timestamp as ID
          title: _titleController.text,
          price: _priceController.text,
          imageUrl: _imageUrlController.text,
          category: _selectedCategory!, // Add category field
        );

        // Save artwork to Firestore
        final docRef = FirebaseFirestore.instance.collection('artworks').doc(artwork.id);
        await docRef.set(artwork.toMap());

        // Navigate back and show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Artwork added successfully!')),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        // Handle errors
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add artwork: $e')),
          );
        }
      } finally {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Artwork'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Title Field
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
                ),
                const SizedBox(height: 10),

                // Price Field
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Image URL Field
                TextFormField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  validator: (value) => value!.isEmpty ? 'Please enter an image URL' : null,
                ),
                const SizedBox(height: 10),

                // Category Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a category' : null,
                ),
                const SizedBox(height: 20),

                // Submit Button with Loading Indicator
                _isLoading
                    ? const CircularProgressIndicator() // Show loading while adding artwork
                    : ElevatedButton(
                        onPressed: _addArtwork,
                        child: const Text('Add Artwork'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers to free resources
    _titleController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
}