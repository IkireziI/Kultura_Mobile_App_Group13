import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  Future<void> _changePassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'New password and confirm password do not match.';
      });
      return;
    }

    if (newPassword.length < 6) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Password must be at least 6 characters long.';
      });
      return;
    }

    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Reauthenticate user with current password
        final AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );

        await user.reauthenticateWithCredential(credential);

        // Update password
        await user.updatePassword(newPassword);

        setState(() {
          _isLoading = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password changed successfully!')),
          );
          Navigator.pop(context);  // Close the screen after password is changed
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to change password: $e';
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage)),
        );
      }
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField(
              label: 'Current Password',
              controller: _currentPasswordController,
              obscureText: !_isCurrentPasswordVisible,
              toggleVisibility: _toggleCurrentPasswordVisibility,
            ),
            _buildTextField(
              label: 'New Password',
              controller: _newPasswordController,
              obscureText: !_isNewPasswordVisible,
              toggleVisibility: _toggleNewPasswordVisibility,
            ),
            _buildTextField(
              label: 'Confirm New Password',
              controller: _confirmPasswordController,
              obscureText: !_isConfirmPasswordVisible,
              toggleVisibility: _toggleConfirmPasswordVisibility,
            ),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading ? null : _changePassword,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Change Password'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to toggle password visibility for current password
  void _toggleCurrentPasswordVisibility() {
    setState(() {
      _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
    });
  }

  // Function to toggle password visibility for new password
  void _toggleNewPasswordVisibility() {
    setState(() {
      _isNewPasswordVisible = !_isNewPasswordVisible;
    });
  }

  // Function to toggle password visibility for confirm password
  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  // Build the text field with the ability to toggle password visibility
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback toggleVisibility,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: toggleVisibility,
          ),
        ),
      ),
    );
  }
}
