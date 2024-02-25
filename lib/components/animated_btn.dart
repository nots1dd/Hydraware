import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';

class AnimatedBtn extends StatefulWidget {
  final double? height;
  final double? width;
  final String asset;
  final controller;
  const AnimatedBtn(
      {super.key,
      this.controller,
      required this.asset,
      required this.height,
      required this.width});

  @override
  State<AnimatedBtn> createState() => _AnimatedBtnState();
}

class _AnimatedBtnState extends State<AnimatedBtn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool searched = false;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: GestureDetector(
        onTap: () {
          if (searched == false) {
            _controller.forward();
            searched = true;
          } else {
            _controller.reset();
            searched = false;
          }
        },
        child: Lottie.asset(widget.asset,
            height: widget.height,
            width: widget.width,
            controller: _controller),
      ),
    );
  }
}
