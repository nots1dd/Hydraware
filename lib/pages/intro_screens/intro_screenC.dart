import 'package:flutter/material.dart';

class ScreenC extends StatelessWidget {
  const ScreenC({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[800],
      child: const Center(
        child: Text('Screen C',
            style: TextStyle(color: Colors.black, fontSize: 24)),
      ),
    );
  }
}
