import 'package:flutter/material.dart';

class EventButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EventButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Determine if it's a large screen
    final isLargeScreen = screenWidth > 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,  // 5% of the screen width for horizontal padding
        vertical: screenHeight * 0.02,   // 2% of the screen height for vertical padding
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: isLargeScreen ? 20 : 15,  // Larger padding for large screens
            horizontal: isLargeScreen ? 40 : 30, // Larger horizontal padding for large screens
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 6,
          shadowColor: Colors.tealAccent.withOpacity(0.5),
        ),
        onPressed: onPressed,
        child: Text(
          'Add Event',
          style: TextStyle(
            fontSize: isLargeScreen ? 24 : 20,  // Larger font size for large screens
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
