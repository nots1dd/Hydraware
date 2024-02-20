import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[500],
      child: Column(
        children: [
          const SizedBox(height: 60),
          Lottie.asset('assets/images/Hydraware_animation_1.json', width: 200, height: 200),
        ],
      )
    );
  }
}