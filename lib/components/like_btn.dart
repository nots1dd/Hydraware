import 'package:flutter/material.dart';

class LikeBtn extends StatelessWidget {
  final bool isVoted;
  void Function()? onTap;
  LikeBtn({super.key, required this.isVoted, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isVoted
          ? Icon(
              Icons.favorite,
              color: Theme.of(context).colorScheme.primary,
            )
          : Icon(
              Icons.favorite_border,
              color: Theme.of(context).colorScheme.primary,
            ),
    );
  }
}
