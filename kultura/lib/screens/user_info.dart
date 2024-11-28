import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kultura/screens/edit_prof.dart';
// import 'package:kultura/screens/edit_prof.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic> _userData = {
    'name': 'N/A',
    'email': 'N/A',
    'phone': 'N/A',
    'registeredAt': 'N/A',
    'uid': 'N/A',
  };
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (!userDoc.exists) {
          await _firestore.collection('users').doc(currentUser.uid).set({
            'name': currentUser.displayName ?? 'New User',
            'email': currentUser.email,
            'phone': 'Not provided',
            'Created': FieldValue.serverTimestamp(),
          });
          userDoc = await _firestore.collection('users').doc(currentUser.uid).get();
        }

        setState(() {
          _userData = {
            'email': currentUser.email ?? 'Not provided',
            'uid': currentUser.uid,
            'name': userDoc['name'] ?? currentUser.displayName ?? 'New User',
            'phone': 'Not provided',
            'registeredAt': 'not available'
          };
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching user data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          IconButton(
  icon: const Icon(Icons.edit),
  onPressed: () {
    // Ensure user data is not empty before navigation
    if (_userData.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProfileScreen(userData: _userData),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: No user data found.')),
      );
    }
  },
),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildProfileItem(
                        icon: Icons.person,
                        label: 'Name',
                        value: _userData['name'],
                      ),
                      _buildProfileItem(
                        icon: Icons.email,
                        label: 'Email',
                        value: _userData['email'],
                      ),
                      _buildProfileItem(
                        icon: Icons.phone,
                        label: 'Phone',
                        value: _userData['phone'],
                      ),
                      _buildProfileItem(
                        icon: Icons.calendar_today,
                        label: 'Registered On',
                        value: _userData['registeredAt'],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            await _auth.signOut();
                            Navigator.of(context).pushReplacementNamed('/login');
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color.fromARGB(255, 199, 50, 171),
                          ),
                          child: const Text('Logout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
