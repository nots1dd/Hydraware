import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class pwdTextField extends StatefulWidget {
  final controller;
  final String hintText;
  bool isPassword;
  pwdTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.isPassword});

  @override
  State<pwdTextField> createState() => _pwdTextFieldState();
}

// ignore: camel_case_types
class _pwdTextFieldState extends State<pwdTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(20)),
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            hintText: widget.hintText,
            hintStyle: const TextStyle(fontFamily: 'Cera Pro'),
            suffixIcon: GestureDetector(
              onTap: () => {
                setState(() {
                  widget.isPassword = !widget.isPassword;
                })
              },
              child: Icon(
                  widget.isPassword ? Icons.visibility_off : Icons.visibility),
            )),
        obscureText: widget.isPassword,
      ),
    );
  }
}
