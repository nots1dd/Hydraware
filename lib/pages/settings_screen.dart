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
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withAlpha(15)),
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).colorScheme.onPrimary),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/icon.png',
                        height: 100,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hydraware',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                fontFamily: 'Cera Pro'),
                          ),
                          Text(
                            'ver 0.9',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontFamily: 'Cera Pro'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SettingItem(
                    context: context,
                    page: '/privacy',
                    label: 'Privacy Policy'),
                const SizedBox(height: 10),
                // Divider(
                //   thickness: 0.75,
                //   color: Theme.of(context).colorScheme.secondary,
                // ),
                const SizedBox(height: 10),
                SettingItem(
                    context: context, page: '/license', label: 'License'),
                const SizedBox(height: 10),
                // Divider(
                //   thickness: 0.75,
                //   color: Theme.of(context).colorScheme.secondary,
                // ),
                const SizedBox(height: 10),
                SettingItem(
                    context: context, page: '/profile', label: 'Profile'),
                const SizedBox(height: 10),
                // Divider(
                //   thickness: 0.75,
                //   color: Theme.of(context).colorScheme.secondary,
                // ),
                const SizedBox(height: 10),
                SettingItem(context: context, page: '/', label: 'About'),
                const SizedBox(height: 50),
                MyButton(onTap: signUserOut, text: 'Sign Out'),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Change Theme:',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
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
      ),
    );
  }

  Widget SettingItem(
      {required BuildContext context,
      required String page,
      required String label,
      String? description}) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, page);
      },
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cera Pro'),
          ),
          if (description != null)
            Text(
              description,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cera Pro'),
            ),
        ],
      ),
    );
  }
}
