import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[800],
      child: Column(
        children: [
          const SizedBox(height: 60), // Placeholder for now
          Center(
            child: Column(
              children: [
                Text(
                  'Be mindful, Be sustainable',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20), // Placeholder for now
                Lottie.asset('assets/images/Hydraware_animation_1.json',
                    width: 200, height: 200),
                    
              ],
            ),
          ),
        ],
      ),
    );
  }
}
