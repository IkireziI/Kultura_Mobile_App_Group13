import 'package:flutter/material.dart';

class AppStyles{
  static const Color primaryPurple = Color(0xFF8B1FF8);
  static const Color lightPink = Color(0xFFF8E8FF);

  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryPurple,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 15),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),

    )
  );
  static InputDecoration textFieldDecoration(String hint, IconData icon){
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color:Colors.grey),
      filled:true,
      fillColor: lightPink,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      )
    );
  }
}