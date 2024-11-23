import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign up a new user
  Future<String?> signup({
    required String email,
    required String password, required BuildContext context,
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
    required String password, required BuildContext context,
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

  /// Sign out the current user
  Future<void> signout({required BuildContext context}) async {
    try {
      await _auth.signOut();
    } catch (e) {
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
}
