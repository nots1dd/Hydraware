import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hydraware/components/textfield.dart';

class ForgotPwd extends StatefulWidget {
  const ForgotPwd({super.key});

  @override
  State<ForgotPwd> createState() => _ForgotPwdState();
}

class _ForgotPwdState extends State<ForgotPwd> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void invalidAuth(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 30,
            height: 60,
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
                        fontSize: 25)),
              ),
            ),
          ),
        );
      },
    );
  }

  Future passwordReset() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                  'Password reset link sent to ${_emailController.text.trim()}!'),
            );
          });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        automaticallyImplyLeading: false,
        title: const Text(
          'Forgot Password',
          style: TextStyle(fontFamily: 'Cera Pro'),
        ),
        actions: [
          KeyboardDismissOnTap(
            dismissOnCapturedTaps: true,
            child: IconButton(
              onPressed: () {
                Future.delayed(const Duration(milliseconds: 200), () {
                  Navigator.pop(context);
                });
              },
              icon: const Icon(Icons.close),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Center(
                child: Text(
              'Hydraware',
              style: TextStyle(
                  fontFamily: 'Cera Pro',
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            )),
            const SizedBox(height: 30),
            MyTextField(
                controller: _emailController,
                hintText: 'Enter mail ID to reset password',
                obscureText: false),
            const SizedBox(height: 20),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                constraints: const BoxConstraints(
                  maxWidth: 200,
                ),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: IconButton(
                  onPressed: passwordReset,
                  icon: Row(
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Center(
                          child: Text(
                        'Send',
                        style: TextStyle(
                            fontFamily: 'Cera Pro',
                            color: Theme.of(context).colorScheme.onPrimary),
                      )),
                      const SizedBox(
                        width: 30,
                      ),
                      Icon(
                        Icons.send,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ],
                  ),
                  iconSize: 30,
                  color: Theme.of(context).colorScheme.secondary,
                )),
            const SizedBox(height: 20),
            const Divider(
              thickness: 0.6,
            ),
            const SizedBox(height: 30),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              child: Text(
                'Enter the mail ID that was logged into Hydraware and get the reset link',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 20,
                  fontFamily: 'Cera Pro',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
