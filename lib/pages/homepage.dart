import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:login/pages/homescreen.dart';
import 'package:login/pages/searchscreen.dart';
import 'package:login/pages/settings_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(), //TODO: Set screens
    SearchScreen(),
    SettingsScreen(),
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Welcome",style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            onPressed: widget.signUserOut,
            icon: const Icon(Icons.logout, color: Colors.white),
          )
        ],
      ),
      body: Center(
        child: widget._widgetOptions.elementAt(widget._selectedIndex),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 15.0),
          child: GNav(
            haptic: true,
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade900,
            padding: const EdgeInsets.all(18),
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