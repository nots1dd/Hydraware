import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hydraware/pages/homescreen.dart';
import 'package:hydraware/pages/searchscreen.dart';
import 'package:hydraware/pages/settings_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;


  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(), //TODO: Set screens
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
        title:  Text("Hydraware",style: TextStyle(color: Theme.of(context).colorScheme.tertiary)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: Icon(Icons.account_circle_outlined,color: Theme.of(context).colorScheme.tertiary,),
          )
        ],
      ),
      body: Center(
        child: widget._widgetOptions.elementAt(widget._selectedIndex),
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 15.0),
          child: GNav(
            haptic: true,
            backgroundColor: Theme.of(context).colorScheme.background,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade900,
            padding: const EdgeInsets.all(10),
            gap: 5,
            tabs: const  [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.search, text: 'Search'),
              GButton(icon: Icons.settings, text: 'Settings')
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
    );
  }
}