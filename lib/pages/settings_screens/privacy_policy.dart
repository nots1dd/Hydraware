import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Privacy Policy', style: TextStyle(
          color: Colors.blueAccent,),textAlign: TextAlign.left,),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,color: Theme.of(context).colorScheme.tertiary,),
          )
        ],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 30),
                Text('Privacy Policy', style: TextStyle(
                  fontSize: 30)),
              ],
            ),
          ),
        ),
      )
    );
  }
}