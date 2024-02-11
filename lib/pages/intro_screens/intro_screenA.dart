import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[600],
      child: Column(
        children: [
          SizedBox(height: 100),
          Text('Welcome to Hydraware', style: TextStyle(
            color: Colors.blue[850],
            fontSize: 24)),
          SizedBox(height: 100),
          Lottie.asset('lib/images/Hydraware_animation_1.json', width: 200, height: 200),
          Text('Screen A', style: TextStyle(
          color: Colors.white,
          fontSize: 24)),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}