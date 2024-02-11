import 'package:flutter/material.dart';

class ScreenC extends StatelessWidget {
  const ScreenC({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[400],
      child: const Center(
        child: Text('Screen C', style: TextStyle(
          color: Colors.white,
          fontSize: 24)),
      ),
    );
  }
}