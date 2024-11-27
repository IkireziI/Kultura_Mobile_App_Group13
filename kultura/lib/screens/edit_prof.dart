import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  EditProfileScreen({required this.userData});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _phoneController;
  late TextEditingController _occupationController;
  late TextEditingController _nationalityController;

  // Add a variable to store the selected role
  String? _selectedRole;
  final List<String> _roles = ['Admin', 'User', 'Editor', 'Viewer'];

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(
        text: widget.userData['phone'] ?? 'Not Provided');
    _occupationController = TextEditingController(
        text: widget.userData['occupation'] ?? 'Not Provided');
    _nationalityController = TextEditingController(
        text: widget.userData['nationality'] ?? 'Not Provided');

    // Initialize the role with the current user's role
    _selectedRole = widget.userData['role'] ?? _roles.first;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userData.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Edit Profile')),
        body: const Center(child: Text('No data available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _updateProfile,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildReadOnlyTextField(
              label: 'Name',
              value: widget.userData['name'],
              icon: Icons.person,
            ),
            _buildReadOnlyTextField(
              label: 'Email',
              value: widget.userData['email'],
              icon: Icons.email,
            ),
            _buildEditableTextField(
              label: 'Phone',
              controller: _phoneController,
              icon: Icons.phone,
            ),
            _buildEditableTextField(
              label: 'Occupation',
              controller: _occupationController,
              icon: Icons.work,
            ),
            _buildEditableTextField(
              label: 'Nationality',
              controller: _nationalityController,
              icon: Icons.language,
            ),
            _buildRoleDropdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyTextField({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              '$label: $value',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 16.0),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Dropdown widget for role selection
  Widget _buildRoleDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.assignment_ind, color: Colors.grey),
          const SizedBox(width: 16.0),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedRole,
              items: _roles.map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedRole = newValue;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Role',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateProfile() async {
    var userDocRef =
        FirebaseFirestore.instance.collection('users').doc(widget.userData['id']);
        print("Document ID: ${widget.userData['id']}");

    final updatedData = {
      'phone': _phoneController.text,
      'occupation': _occupationController.text,
      'nationality': _nationalityController.text,
      'role': _selectedRole,
    };

    try {
      await userDocRef.update(updatedData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );

      Navigator.pop(context, updatedData);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile')),
      );
    }
  }
}
