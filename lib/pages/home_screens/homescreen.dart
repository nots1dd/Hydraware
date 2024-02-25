import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Text('Home',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 30)),
        ));
  }
}
