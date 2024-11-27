// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kultura/screens/home.dart';
import 'package:kultura/screens/log_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign up a new user
  Future<void> signup({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to Home page on successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Home()),
      );
    } on FirebaseAuthException catch (e) {
      String message = _handleAuthError(e);
      _showToast(message);
    } catch (e) {
      _showToast('An unexpected error occurred. Please try again.');
      debugPrint('Error during signup: $e');
    }
  }

  /// Sign in an existing user
  Future<String> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Successfully logged in"; // Success message
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An error occurred"; // Error message
    }
  }

  /// Sign out the current user
  Future<void> signout({
    required BuildContext context,
  }) async {
    try {
      await _auth.signOut();

      // Navigate to Login page after signing out
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (e) {
      _showToast('An error occurred while signing out. Please try again.');
      debugPrint('Error during signout: $e');
    }
  }

 /// Reset user password
Future<String> resetPassword({
  required String email,
  required BuildContext context,
}) async {
  try {
    await _auth.sendPasswordResetEmail(email: email);
    return 'Password reset email sent! Please check your inbox.';
  } on FirebaseAuthException catch (e) {
    return _handleAuthError(e);
  } catch (e) {
    debugPrint('Error during password reset: $e');
    return 'An unexpected error occurred. Please try again.';
  }
}

  

  /// Handle FirebaseAuthException errors
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists with that email.';
      case 'user-not-found':
        return 'No user found with that email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'The email address is not valid.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  /// Show toast message
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
}
