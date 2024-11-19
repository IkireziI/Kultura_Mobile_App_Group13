// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: use_key_in_widget_constructors
class AddPortfolioPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _AddPortfolioPageState createState() => _AddPortfolioPageState();
}

class _AddPortfolioPageState extends State<AddPortfolioPage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String imageUrl = '';
  bool isLoading = false; // To manage the loading state

  Future<void> savePortfolio() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        isLoading = true; // Show loading indicator
      });

      try {
        // Save to Firestore
        await FirebaseFirestore.instance.collection('portfolios').add({
          'title': title,
          'description': description,
          'imageUrl': imageUrl.isNotEmpty ? imageUrl : null, // Optional field
          'createdAt': DateTime.now().toIso8601String(),
        });

        // Show success SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Portfolio added successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context); // Go back to the previous page
      } catch (e) {
        // Show error SnackBar
        // ignore: duplicate_ignore
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add portfolio: $e'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          isLoading = false; // Hide loading indicator
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Portfolio')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? 'Please enter a title' : null,
                onSaved: (value) => title = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? 'Please enter a description' : null,
                onSaved: (value) => description = value!,
                maxLines: 3, // Allow multiline input for description
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Portfolio URL (optional)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    // Simple URL validation
                    final urlPattern = RegExp(
                      r'^(https?|ftp)://[^\s/$.?#].[^\s]*$',
                      caseSensitive: false,
                    );
                    if (!urlPattern.hasMatch(value)) {
                      return 'Please enter a valid URL';
                    }
                  }
                  return null;
                },
                onSaved: (value) => imageUrl = value!,
              ),
              SizedBox(height: 20),
              isLoading
                  ? Center(child: CircularProgressIndicator()) // Show loader
                  : ElevatedButton(
                onPressed: savePortfolio,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Full-width button
                ),
                child: Text('Save Portfolio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}