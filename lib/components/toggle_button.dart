import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final String dir;
  const ToggleButton({super.key,required this.dir});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 240),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, widget.dir);
        }, 
        child: Icon(Icons.chat_bubble_rounded,color: Theme.of(context).colorScheme.tertiary,size: 30,)),
    );
  }
}