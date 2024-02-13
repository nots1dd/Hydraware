import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const MyTextField({super.key, required this.controller, required this.hintText, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: controller,
                  obscureText: obscureText, //to hide passwords
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)
                    ),
                    fillColor: Theme.of(context).colorScheme.secondary,
                    filled: true,
                    hintText: hintText,
                  ),
                  style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
              );
  }
}