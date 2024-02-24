import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final String dir;
  const ToggleButton({super.key, required this.dir});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.background,
        onPressed: () {
          Navigator.pushNamed(context, widget.dir);
        },
        child: Icon(
          Icons.chat_bubble_rounded,
          color: Theme.of(context).colorScheme.primary,
          size: 30,
        ));
  }
}
