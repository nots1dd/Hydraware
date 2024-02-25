import 'package:flutter/material.dart';

class ScreenC extends StatelessWidget {
  const ScreenC({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Designer_1.jpeg'),
              fit: BoxFit.cover, // Adjust as needed
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20.0), // Add padding for text
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            children: [
              const SizedBox(height: 40), // Adjust spacing
              Text( // Centered horizontally by default in Column
                'Ready for your hydroful journey?',
                style: TextStyle(
                  color: Colors.white, // White text for contrast
                  fontSize: 26,
                  fontFamily: 'Cera Pro',
                  fontWeight: FontWeight.bold,
                ),
              ), // Added missing closing parenthesis for Text widget
              const SizedBox(height: 20), // Adjust spacing
              // ... your other widgets here
            ],
          ),
        ),
      ],
    );
  }
}
