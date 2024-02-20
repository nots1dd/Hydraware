import 'package:flutter/material.dart';
import 'package:hydraware/pages/loginpage.dart';
import 'package:hydraware/pages/register.dart';

class AuthMiddle extends StatefulWidget {
  const AuthMiddle({super.key});

  @override
  State<AuthMiddle> createState() => _AuthMiddleState();
}

class _AuthMiddleState extends State<AuthMiddle> {

  bool showRegisterPage = true;

  void togglePages() {
    setState(() {
      showRegisterPage = !showRegisterPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showRegisterPage) {
      return RegisterPage(onTap: togglePages);
    }
    else {
      return LoginPage(onTap: togglePages,);
    }
  }
}