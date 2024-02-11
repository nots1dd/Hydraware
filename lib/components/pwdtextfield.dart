// import 'package:flutter/material.dart';

// class PWDTextField extends StatelessWidget {
//   final controller;
//   final String hintText;
//   bool obscureText;
//   PWDTextField({super.key, required this.controller, required this.hintText, required this.obscureText});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(
//           width: 285,
//                 child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                       child: TextField(
//                         controller: controller,
//                         obscureText: obscureText, //to hide passwords
//                         decoration: InputDecoration(
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)
//                           ),
//                           fillColor: Theme.of(context).colorScheme.secondary,
//                           filled: true,
//                           hintText: hintText,
//                           hintStyle: TextStyle(color: Colors.grey[500])
//                         ),
//                         style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
//                       ),
//                     ),
//         ),
//         Container(
//           width: 50,
//           color: Theme.of(context).colorScheme.secondary,
//           alignment: Alignment.center,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25.0),
//             child: GestureDetector(
//               onTap: () => {
//                 obscureText = true
//               },
//               child: Icon(Icons.visibility, color: Theme.of(context).colorScheme.primary, size: 30,)),
//           ))
//       ],
//     );
//   }
// }