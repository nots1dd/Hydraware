import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hydraware/components/button.dart';
import 'package:hydraware/pages/settings_screens/theme.dart';

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
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cera Pro'),
                ),
              ),
              const SizedBox(height: 10),
              Divider(
                thickness: 0.75,
                color: Theme.of(context).colorScheme.secondary,
              ),
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
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cera Pro'),
                ),
              ),
              const SizedBox(height: 10),
              Divider(
                thickness: 0.75,
                color: Theme.of(context).colorScheme.secondary,
              ),
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
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cera Pro'),
                ),
              ),
              const SizedBox(height: 10),
              Divider(
                thickness: 0.75,
                color: Theme.of(context).colorScheme.secondary,
              ),
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
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cera Pro'),
                ),
              ),
              const SizedBox(height: 50),
              MyButton(onTap: signUserOut, text: 'Sign Out'),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Change Theme:',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        fontFamily: 'Cera Pro'),
                  ),
                  const ThemePage(
                    height: 60,
                    width: 100,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
