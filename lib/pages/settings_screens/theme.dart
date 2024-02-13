import 'package:flutter/material.dart';
import 'package:hydraware/pages/settings_screens/theme/dark_theme.dart';
import 'package:hydraware/pages/settings_screens/theme/light_theme.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:hydraware/pages/settings_screens/theme/theme_provider.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(seconds: 2),vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isSwitched = false;

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isSwitched == false) {
          isSwitched = true;
          _controller.forward();
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme(darkTheme);
        }
        else{
          isSwitched = false;
          _controller.reverse();
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme(lightTheme);
        }
      },
      child: Lottie.asset('lib/images/Hydraware_theme_animation.json', width: 100, height: 50,controller: _controller));
  }
}