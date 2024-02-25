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
          ? const Icon(
              Icons.favorite,
              color: Colors.red,
            )
          : const Icon(
              Icons.favorite_border,
              color: Colors.red,
            ),
    );
  }
}
