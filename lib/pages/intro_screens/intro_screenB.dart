import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

class ScreenB extends StatefulWidget {
  const ScreenB({super.key});

  @override
  State<ScreenB> createState() => _ScreenBState();
}

class _ScreenBState extends State<ScreenB> {

  void prompt(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 30,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(message,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontFamily: 'Cera Pro')),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

   Future<void> _checkPermission() async {
    // Check if location permission is granted
    var status = await Permission.location.status;
    if (!status.isGranted) {
      // Request location permission
      var result = await Permission.location.request();
      if (result.isGranted) {
        // Permission granted
        prompt('Location permission granted');
      } else {
        // Permission denied
        prompt('Location permission denied');
      }
    } else {
      // Permission already granted
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[800],
      child: Column(
        children: [
          const SizedBox(height: 60), // Placeholder for now
          Center(
            child: Column(
              children: [
                const Text(
                  'Be mindful, Be sustainable',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20), // Placeholder for now
                Lottie.asset('assets/images/Hydraware_animation_1.json',
                    width: 200, height: 200),
                    
              ],
            ),
          ),
        ],
      ),
    );
  }
}
