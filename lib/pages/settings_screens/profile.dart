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
          color: Colors.blueAccent, fontFamily: 'Cera Pro'),textAlign: TextAlign.left,),
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
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Icon(Icons.person, size: 50, color: Theme.of(context).colorScheme.tertiary,),
                ),
                const SizedBox(height: 20),
                const Center(child: Text('Signed in as: ',style: TextStyle(fontSize: 25,fontFamily: 'Cera Pro',fontWeight: FontWeight.bold),)),
                const SizedBox(height: 10),
                Text('${user.email}', style: const TextStyle(
                  fontSize: 20, fontFamily: 'Cera Pro',fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ),
      )
    );
  }
}