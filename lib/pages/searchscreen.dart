import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Text('Searching', style: TextStyle(
          fontSize: 30,color: Theme.of(context).colorScheme.primary,)),
      )
    );
  }
}