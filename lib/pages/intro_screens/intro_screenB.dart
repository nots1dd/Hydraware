import 'package:flutter/material.dart';

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[500],
      child: const Center(
        child: Text('Screen B', style: TextStyle(
          color: Colors.white,
          fontSize: 24)),
      ),
    );
  }
}