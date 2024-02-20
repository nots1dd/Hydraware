import 'package:flutter/material.dart';

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
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 30),
                Text('License by who?', style: TextStyle(
                  fontSize: 30)),
              ],
            ),
          ),
        ),
      )
    );
  }
}