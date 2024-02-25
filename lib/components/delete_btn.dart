import 'package:flutter/material.dart';

class DelBtn extends StatelessWidget {
  final Function()? onTap;
  const DelBtn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 50,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        // decoration: BoxDecoration(
        //   color: Theme.of(context).colorScheme.tertiary,
        //   borderRadius: BorderRadius.circular(20),),
        child: Center(
          child: Icon(
            Icons.delete,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
      ),
    );
  }
}
