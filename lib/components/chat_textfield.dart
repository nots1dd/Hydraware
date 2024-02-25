import 'package:flutter/material.dart';

class ChatTextField extends StatefulWidget {
  final submit;
  final msgController;
  const ChatTextField(
      {super.key, required this.msgController, required this.submit});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.msgController,
            decoration: InputDecoration(
              hintText: 'Type a message',
              hintStyle: const TextStyle(fontFamily: 'Cera Pro'),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.onSurface),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 2.6),
                borderRadius: BorderRadius.circular(15),
              ),
              // fillColor: Theme.of(context).colorScheme.secondary,
              filled: true,
              suffixIcon: GestureDetector(
                onTap: widget.submit,
                child: Icon(Icons.send,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
        )
      ],
    );
  }
}
