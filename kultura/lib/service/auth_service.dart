import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kultura/pages/home.dart';
import 'package:kultura/pages/log_in.dart';

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
  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to Home page on successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Home()),
      );
    } on FirebaseAuthException catch (e) {
      String message = _handleAuthError(e);
      _showToast(message);
    } catch (e) {
      _showToast('An unexpected error occurred. Please try again.');
      debugPrint('Error during signin: $e');
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
        MaterialPageRoute(builder: (_) => const Login()),
      );
    } catch (e) {
      _showToast('An error occurred while signing out. Please try again.');
      debugPrint('Error during signout: $e');
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
