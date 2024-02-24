import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hydraware/pages/home_screens/home_map_page.dart';
import 'package:hydraware/pages/searchscreen.dart';
import 'package:hydraware/pages/settings_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    MapApp(),
    const SearchScreen(),
    SettingsScreen(),
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Hydraware",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontFamily: 'Cera Pro',
                fontSize: 20)),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: widget._widgetOptions.elementAt(widget._selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 11.0, vertical: 15.0),
            child: GNav(
              haptic: true,
              backgroundColor: Theme.of(context).colorScheme.background,
              color: Theme.of(context).colorScheme.onBackground,
              activeColor: Theme.of(context).colorScheme.primary,
              tabBackgroundColor: Theme.of(context).colorScheme.primary.withAlpha(60),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              gap: 6,
              tabs: [
                bottomNavBarButton(Icons.home, 'Home'),
                bottomNavBarButton(Icons.search, 'Search'),
                bottomNavBarButton(Icons.settings, 'Settings'),
              ],
              selectedIndex: widget._selectedIndex,
              onTabChange: (index) {
                setState(() {
                  widget._selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  GButton bottomNavBarButton(IconData icon, String text) {
    return GButton(
        icon: icon,
        text: text,
        textStyle: TextStyle(
            fontFamily: 'Cera Pro',
            color: Theme.of(context).colorScheme.primary),
    );
  }
}
