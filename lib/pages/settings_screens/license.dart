import 'package:flutter/material.dart';
import 'package:hydraware/pages/settings_screens/license_string.dart';

class License extends StatelessWidget {
  const License({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'License',
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
                    const SizedBox(height: 10),
                    Text(license,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Cera Pro',
                        )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
