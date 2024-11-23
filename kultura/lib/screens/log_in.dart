// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kultura/config/styles_constants.dart';
import 'package:kultura/service/auth_service.dart';
import 'package:kultura/screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  String? _errorMessage; // Holds the error message to display near the input fields

  /// Displays a toast with a given message
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  /// Handles the login logic
  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _errorMessage = null; // Reset error message
      });

      String? errorMessage = await AuthService().signin(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        context: context,
      );

      if (errorMessage == null) {
        // Navigate to Home on successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Home()),
        );
      } else {
        // Display the error message
        setState(() {
          _errorMessage = errorMessage;
        });

        // toast for visibility
        _showToast(errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

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
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                // Display error message if any
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),

                const SizedBox(height: 25),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: AppStyles.primaryButtonStyle,
                    onPressed: _handleLogin,
                    child: const Text('Log In'),
                  ),
                ),

                const SizedBox(height: 20),

                // Or Log In with section
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Or Log In with'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 20),

                // Sign Up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('You do not have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                      child: const Text(
                        'Sign Up',
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
