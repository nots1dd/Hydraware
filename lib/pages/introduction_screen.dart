import 'package:flutter/material.dart';
import 'package:hydraware/pages/intro_screens/intro_screenA.dart';
import 'package:hydraware/pages/intro_screens/intro_screenB.dart';
import 'package:hydraware/pages/intro_screens/intro_screenC.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                if (index == 2) {
                  onLastPage = true;
                } else {
                  onLastPage = false;
                }
              });
            },
            children: const [
              ScreenA(),
              ScreenB(),
              ScreenC(),
            ],
          ),
          Container(
            alignment: const Alignment(0,0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                onTap: () => {
                  Navigator.pushNamed(context, '/login')
                },
                child: const Text('Skip',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),)),
                SmoothPageIndicator(controller: _controller, count: 3,effect: ExpandingDotsEffect(dotColor: Colors.blue[800]!,activeDotColor: Colors.blue[900]!),),
                onLastPage? GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(context, '/login')
                  },
                  child: const Text('Done', style: TextStyle(fontSize: 17, color: Colors.black,fontWeight: FontWeight.bold,)))
                  : GestureDetector(
                    onTap: () => {
                      _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn)
                    },
                    child: const Text('Next', style: TextStyle(fontSize: 17, color: Colors.black,fontWeight: FontWeight.bold,))),
              ],
            ))
        ],
        ),
      );
  }
}