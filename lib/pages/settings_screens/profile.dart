import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile Settings', style: TextStyle(
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Text('You are : ${user.email}', style: const TextStyle(
                  fontSize: 20)),
              ],
            ),
          ),
        ),
      )
    );
  }
}