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
        title: const Text('License', style: TextStyle(
          color: Colors.blueAccent,fontFamily: 'Cera Pro'),textAlign: TextAlign.left,),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,color: Theme.of(context).colorScheme.tertiary,),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(license, style: TextStyle(
                  fontSize: 14,fontFamily: 'Cera Pro',color: Theme.of(context).colorScheme.tertiary)),
              ],
            ),
          ),
        ),
      )
    );
  }
}