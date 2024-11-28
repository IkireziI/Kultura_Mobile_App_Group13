import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kultura/config/styles_constants.dart';
import 'package:kultura/service/auth_service.dart';
import 'package:provider/provider.dart';
import 'provider.dart'; // Ensure this file contains the SignUpScreenProvider class.
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;  // Manage the loading spinner

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpScreenProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Logo/Image
                Image.asset(
                  'assets/kultura_logo.png',
                  height: 200,
                ),
                const SizedBox(height: 20),

                const Text(
                  'Create an account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Full Name TextField
                TextFormField(
                  controller: _nameController,
                  decoration: AppStyles.textFieldDecoration(
                    'Full Name',
                    Icons.person_outline,
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Email TextField
                TextFormField(
                  controller: _emailController,
                  decoration: AppStyles.textFieldDecoration(
                    'Email',
                    Icons.email_outlined,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your email';
                    }
                    if (!value!.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Password TextField
                TextFormField(
                  controller: _passwordController,
                  decoration: AppStyles.textFieldDecoration(
                    'Password',
                    Icons.lock_outline,
                  ).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        signUpProvider.isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: signUpProvider.togglePasswordVisibility,
                    ),
                  ),
                  obscureText: !signUpProvider.isPasswordVisible,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a password';
                    }
                    if (value!.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Confirm Password TextField
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: AppStyles.textFieldDecoration(
                    'Confirm Password',
                    Icons.lock_outline,
                  ).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        signUpProvider.isConfirmPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: signUpProvider.toggleConfirmPasswordVisibility,
                    ),
                  ),
                  obscureText: !signUpProvider.isConfirmPasswordVisible,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: AppStyles.primaryButtonStyle,
                    onPressed: _isLoading ? null : () async { //Disable if loading
                      if (_formKey.currentState?.validate() ?? false) {
                        setState(() {
                          _isLoading = true; // Show loading spinner
                        });

                        try {
                          await AuthService().signup(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            context: context,
                          );

                          // After successful registration, store additional user info in Firestore
                          User? user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
                              'name': _nameController.text.trim(),
                              'email': _emailController.text.trim(),
                              'createdAt': FieldValue.serverTimestamp(),
                              'username': '', // Empty string, will be updated later
                              'profilePictureUrl': '', // Empty string, will be updated later
                              'posts': [], // Empty list for future posts
                              'stories': [], // Empty list for future stories
                            });
                          }

                          // Navigate to HomePage after successful registration
                          Navigator.pushReplacementNamed(context, '/home');
                        } on FirebaseAuthException catch (e) {
                          Fluttertoast.showToast(
                            msg: e.message ?? 'An error occurred',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.SNACKBAR,
                            backgroundColor: Colors.black54,
                            textColor: Colors.white,
                            fontSize: 14.0,
                          );
                          print('Error: ${e.message}');
                        } catch (e) {
                          Fluttertoast.showToast(
                            msg: 'Unexpected error occurred. Please try again.',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.SNACKBAR,
                            backgroundColor: Colors.black54,
                            textColor: Colors.white,
                            fontSize: 14.0,
                          );
                        } finally {
                          setState(() {
                            _isLoading = false; // Hide loading spinner
                          });
                        }
                      }
                    },
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())  // Show spinner while loading
                        : const Text('Sign Up'),
                  ),
                ),
                const SizedBox(height: 20),

                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: AppStyles.primaryPurple),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
