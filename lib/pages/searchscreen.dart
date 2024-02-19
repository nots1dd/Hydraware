import 'package:flutter/material.dart';
import 'package:hydraware/components/toggle_button.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const SizedBox(height: 100),
          Center(
            child: Text('Searching', style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 30)),
          ),
          const SizedBox(height: 420),
          const ToggleButton(dir: '/chat',),
        ],
      )
    );
  }
}