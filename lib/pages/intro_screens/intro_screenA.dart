import 'package:flutter/material.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[800],
      child: Column(
        children: [
          const SizedBox(height: 60),
          Text('Welcome to Hydraware',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Cera Pro',
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Container(
              color: Colors.blue[800],
              child: Image.asset(
                'assets/images/icon_alt.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              )),
          const SizedBox(height: 20),
          const Text('Your app for everything hydro!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'Cera Pro',
                  fontWeight: FontWeight.w200)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
