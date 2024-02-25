import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagepath;
  final Function()? onTap;
  const SquareTile({super.key, required this.imagepath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(
                color:
                    Theme.of(context).colorScheme.onBackground.withAlpha(15)),
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.onPrimary),
        child: Image.asset(
          imagepath,
          height: 40,
        ),
      ),
    );
  }
}
