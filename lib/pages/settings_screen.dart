import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hydraware/components/button.dart';
import 'package:hydraware/pages/settings_screens/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/privacy');
                      },
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),),
                    ),
                const SizedBox(height: 10),
                Divider(thickness: 0.75,color: Theme.of(context).colorScheme.secondary,),
                const SizedBox(height: 10),
                GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/license');
                      },
                      child: const Text(
                        'License',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),),
                    ),
                const SizedBox(height: 10),
                Divider(thickness: 0.75,color: Theme.of(context).colorScheme.secondary,),
                const SizedBox(height: 10),
                GestureDetector(
                      onTap: () {
                          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                      }, 
                      child: const Text(
                        'Change Theme',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),),
                    ),
                const SizedBox(height: 10),
                Divider(thickness: 0.75,color: Theme.of(context).colorScheme.secondary,),
                const SizedBox(height: 10),
                GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: const Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),),
                    ),
                const SizedBox(height: 10),
                Divider(thickness: 0.75,color: Theme.of(context).colorScheme.secondary,),
                const SizedBox(height: 10),
                GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: const Text(
                        'About',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),),
                    ),
                const SizedBox(height: 50),
                MyButton(onTap: signUserOut, text: 'Sign Out'),
              ],
          ),
        ),
      ),
    );
    
  }
}