import 'package:flutter/material.dart';
import 'package:hydraware/pages/settings_screens/privacy_policy_string.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Privacy Policy',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                  fontFamily: 'Cera Pro'),
              textAlign: TextAlign.left,
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.background,
              ),
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Text(privacyPolicy,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Cera Pro',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
