

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/components/button.dart';
import 'package:login/components/squaretile.dart';
import 'package:login/components/textfield.dart';
import 'package:login/services/authservice.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

  class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  void invalidAuth(String message) {

    showDialog(
      context: context, 
      builder: (context) {
        return Dialog(
        child: Container(
          width: 30,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),),
        child: Center(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(message, style: const TextStyle(
              color: Colors.grey,
              fontSize: 16)),
          ),
        ),
        ),
         
      );
        },
        );
  }

  void signUserUp() async {
    showDialog(
      context: context, 
      builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
        );
      },
    );
    try {
       if(passwordController.text != confirmpasswordController.text) {
        Navigator.pop(context);
        invalidAuth("Password do not match");
      return;
    }
      if (passwordController.text == confirmpasswordController.text) { //TODO: check for mail domains thru regex (any domain is able to login now)
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text
        );
      } else {
        invalidAuth('Passwords do not match');

      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      invalidAuth(e.message!);

  }}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Icon(Icons.lock, size: 100),
                const SizedBox(height: 30),
                Text('Welcome to this!', style: TextStyle(color: Colors.blue[300],fontSize: 16)),
                const SizedBox(height: 25),
                MyTextField(controller: emailController,hintText: 'Enter mail ID',obscureText: false,),
                const SizedBox(height: 10),
                MyTextField(controller: passwordController,hintText: 'Enter password',obscureText: true,), //textfield.dart for config
                const SizedBox(height: 10),
                MyTextField(controller: confirmpasswordController, hintText: 'Confirm password', obscureText: true),
                const SizedBox(height: 10),
            
                const SizedBox(height: 25,),

                MyButton(onTap: signUserUp, text: 'Sign up!',),
            
                const SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(child: Divider(thickness: 0.75,color: Colors.grey[550],)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),),
                      ),
                      Expanded(child: Divider(thickness: 0.75,color: Colors.grey[550],))
                    ],
                  ),
                ),
            
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  SquareTile(imagepath: 'lib/images/google.png', onTap: () => AuthService().signInWithGoogle(),),
                  const SizedBox( width: 25,),
                  SquareTile(imagepath: 'lib/images/apple.png',onTap: () {},),]),
            
                  const SizedBox(height: 18,),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text('Already a member?',style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(width: 10,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now!',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),),
                    ),
                  ],)
            
            
                  ],
                
            ),
          )
        ),
      ),
    );
  }
  }