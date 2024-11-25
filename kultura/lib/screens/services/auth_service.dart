import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign up a new user
  Future<String?> signup({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e); // Return error message
    } catch (e) {
      debugPrint('Error during signup: $e');
      return 'An unexpected error occurred. Please try again.';
    }
  }

  /// Sign in an existing user
  Future<String?> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e); // Return error message
    } catch (e) {
      debugPrint('Error during signin: $e');
      return 'An unexpected error occurred. Please try again.';
    }
  }

  /// Reset Password
  Future<String?> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'Password reset link sent to your email';
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (e) {
      debugPrint('Error during password reset: $e');
      return 'An unexpected error occurred. Please try again.';
    }
  } // <-- Properly closed here

  /// Sign out the current user
  Future<String?> signout({required BuildContext context}) async {
    try {
      await _auth.signOut();
      if (context.mounted) {
        // Navigate to login screen and clear the navigation stack
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login', // Make sure this route is defined in your app
          (route) => false,
        );
      }
      return null; // Success
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_handleAuthError(e))),
        );
      }
      return _handleAuthError(e);
    } catch (e) {
      debugPrint('Error during signout: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred during sign out. Please try again.'),
          ),
        );
      }
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
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'operation-not-allowed':
        return 'Email & Password accounts are not enabled.';
      case 'invalid-credential':
        return 'Incorrect email or password. Please try again.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
