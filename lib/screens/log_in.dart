import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:kultura/config/styles_constants.dart';
import 'package:kultura/service/auth_service.dart';
import 'package:kultura/screens/home.dart';
import 'package:kultura/screens/reset_password.dart';
import 'provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

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
  Future<void> _handleLogin(LoginScreenProvider loginProvider) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _errorMessage = null; // Reset error message
        _isLoading = true; // Show loading indicator
      });

      String errorMessage = await AuthService().signin(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        context: context,
      );

      setState(() {
        _isLoading = false; // Hide loading indicator
      });

      if (errorMessage == "Successfully logged in") {
        // Navigate to Home on successful login
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Home()),
        );
      } else {
        // Display the error message
        setState(() {
          _errorMessage = errorMessage;
        });
        _showToast(errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginScreenProvider>(context);

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
                        loginProvider.isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: loginProvider.togglePasswordVisibility,
                    ),
                  ),
                  obscureText: !loginProvider.isPasswordVisible,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                // "Forgot Password?" Button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: AppStyles.primaryPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

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
                    onPressed: _isLoading ? null : () => _handleLogin(loginProvider),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Log In'),
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

                // Social login buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _socialLoginButton(
                      'assets/google_icon.png',
                      () {
                        // Handle Google login
                      },
                    ),
                    _socialLoginButton(
                      'assets/facebook_icon.png',
                      () {
                        // Handle Facebook login
                      },
                    ),
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

  Widget _socialLoginButton(String iconPath, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.grey),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 12,
        ),
      ),
      onPressed: onPressed,
      child: Image.asset(iconPath, height: 24),
    );
  }
}
