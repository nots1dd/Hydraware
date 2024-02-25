import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final IconData icon;
  final String dir;
  const ToggleButton({super.key, required this.dir, required this.icon});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.surface,
        onPressed: () {
          Navigator.pushNamed(context, widget.dir);
        },
        child: Icon(
          widget.icon,
          color: Theme.of(context).colorScheme.primary,
          size: 30,
        ));
  }
}
