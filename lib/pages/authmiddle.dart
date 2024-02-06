import 'package:flutter/material.dart';
import 'package:login/pages/loginpage.dart';
import 'package:login/pages/register.dart';

class AuthMiddle extends StatefulWidget {
  const AuthMiddle({super.key});

  @override
  State<AuthMiddle> createState() => _AuthMiddleState();
}

class _AuthMiddleState extends State<AuthMiddle> {

  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    }
    else {
      return RegisterPage(onTap: togglePages,);
    }
  }
}