import 'package:flutter/material.dart';

// ignore: must_be_immutable
class pwdTextField extends StatefulWidget {
  final controller;
  final String hintText;
  bool isPassword;
  pwdTextField({super.key, required this.controller, required this.hintText, required this.isPassword});

  @override
  State<pwdTextField> createState() => _pwdTextFieldState();
}

class _pwdTextFieldState extends State<pwdTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)
        ),
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        hintText: widget.hintText,
        suffixIcon: GestureDetector(
          onTap: () => {
            setState(() {
              widget.isPassword = !widget.isPassword;
            })
          
          },
          child: Icon(widget.isPassword? Icons.visibility_off : Icons.visibility),)
      ),
      obscureText: widget.isPassword,
    ),
  );
  }
}