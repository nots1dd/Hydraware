import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class SearchBtn extends StatefulWidget {
  final controller;
  const SearchBtn({super.key, this.controller});

  @override
  State<SearchBtn> createState() => _SearchBtnState();
}

class _SearchBtnState extends State<SearchBtn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool searched = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (searched == false) {
          _controller.forward();
          searched = true;
        } 
        else {
          _controller.reset();
          searched = false;
        }
      },
      child: Lottie.asset('assets/images/Hydraware_search_animation.json', height: 50, width: 50,controller: _controller),
    );
  }
}