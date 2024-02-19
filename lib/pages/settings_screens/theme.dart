import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hydraware/pages/settings_screens/theme/theme_provider.dart';

class ThemePage extends StatefulWidget {
  final height;
  final width;
  const ThemePage({super.key, this.height, this.width});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {

  bool toggleVal = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: SizedBox(
        height: 60,
        width: 100,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: toggleVal ? Colors.blueGrey.shade600 : Colors.blueGrey.shade800,
              ),
              child: Stack(
                children: <Widget> [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                    top: 3.0,
                    left: toggleVal ? 60.0 : 0.0,
                    right: toggleVal ? 0.0 : 60.0,
                    bottom: 3.0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          toggleVal = !toggleVal;
                          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                        });
                      },
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 150),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return RotationTransition(turns: animation, child: child);
                        },
                        child: toggleVal ? Icon(Icons.light_mode, color: Colors.blue.shade300, key: UniqueKey(),) : Icon(Icons.dark_mode, color: Colors.blue.shade700, key: UniqueKey(),),
                      )
                    )
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}