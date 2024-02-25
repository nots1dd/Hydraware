import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hydraware/components/button.dart';
import 'package:hydraware/components/textfield.dart';
import 'package:hydraware/pages/search_screens/posts/posts_db.dart';
import 'package:profanity_filter/profanity_filter.dart';

class PostScreen extends StatefulWidget {
  PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final FirebaseDatabase database = FirebaseDatabase();

  final TextEditingController contentController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  final filter = ProfanityFilter();

  bool isVoted = false;

  void prompt(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 30,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(message,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontFamily: 'Cera Pro')),
              ),
            ),
          ),
        );
      },
    );
  }

  void postMessage() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      if (contentController.text.isNotEmpty && areaController.text.isNotEmpty) {
        String message = contentController.text;
        String area = areaController.text;
        if(filter.hasProfanity(message) || filter.hasProfanity(area)){
          prompt("Please do not use profanity");
          return;
        }
        await database.addPost(message, area);
        Navigator.pop(context);
        prompt('Post successful!');
      } else {
        Navigator.pop(context);
        prompt('Please enter a message!');
      }
      contentController.clear();
      areaController.clear();
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      prompt(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Post',
            style: TextStyle(
                fontFamily: 'Cera Pro',
                color: Theme.of(context).colorScheme.background),
          ),
          leading: KeyboardDismissOnTap(
            dismissOnCapturedTaps: true,
            child: IconButton(
              onPressed: () async {
                Future.delayed(const Duration(milliseconds: 200), () {
                  Navigator.pop(context);
                });
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          MyTextField(
              controller: contentController,
              hintText: 'Enter your issue!',
              obscureText: false),
          const SizedBox(height: 20),
          MyTextField(
              controller: areaController,
              hintText: 'Enter your area!',
              obscureText: false),
          const SizedBox(height: 20),
          MyButton(onTap: postMessage, text: 'Post')
        ],
      ),
    );
  }
}
