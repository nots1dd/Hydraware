import 'package:flutter/material.dart';
import 'package:hydraware/pages/settings_screens/privacy_policy_string.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Privacy Policy',
            style: TextStyle(color: Colors.blueAccent, fontFamily: 'Cera Pro'),
            textAlign: TextAlign.left,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Text(privacyPolicy,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ));
  }
}
