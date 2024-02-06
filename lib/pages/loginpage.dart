

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/components/button.dart';
import 'package:login/components/squaretile.dart';
import 'package:login/components/textfield.dart';
import 'package:login/services/authservice.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context, 
      builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmailMsg();
      } 
      else if (e.code == 'wrong-password') {
        wrongPasswordMsg();
      }
      else {
        invalidAuth();
      }
    }

  }

  void wrongEmailMsg() {
    showDialog(
      context: context, 
      builder: (context) {
        return Dialog(
        child: Container(
          width: 20,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),),
        child: const Center(
          child: Text('Invalid email', style: TextStyle(
            color: Colors.grey,
            fontSize: 16)),
        ),
        ),
         
      );
    });
  }

  void wrongPasswordMsg() {
    showDialog(
      context: context, 
      builder: (context) {
        return Dialog(
        child: Container(
          width: 20,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),),
        child: const Center(
          child: Text('Invalid password!', style: TextStyle(
            color: Colors.grey,
            fontSize: 16)),
        ),
        ),
         
      );
    });
  }

  void invalidAuth() {
    showDialog(
      context: context, 
      builder: (context) {
        return Dialog(
        child: Container(
          width: 20,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),),
        child: const Center(
          child: Text('Invalid credentials! Try again!!', style: TextStyle(
            color: Colors.grey,
            fontSize: 16)),
        ),
        ),
         
      );
      });
  }

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
                const SizedBox(height: 40),
                Text('Welcome back!', style: TextStyle(color: Colors.blue[300],fontSize: 16)),
                const SizedBox(height: 25),
                MyTextField(controller: emailController,hintText: 'Enter mail ID',obscureText: false,),
                const SizedBox(height: 10),
                MyTextField(controller: passwordController,hintText: 'Enter password',obscureText: true,), //textfield.dart for config
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot password?', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
            
                const SizedBox(height: 25,),

                MyButton(onTap: signUserIn, text: 'Sign In!',),
            
                const SizedBox(height: 50,),
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
                  SizedBox( width: 25,),
                  SquareTile(imagepath: 'lib/images/apple.png',onTap: () {},),]),
            
                  const SizedBox(height: 18,),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text('Not a member?',style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(width: 10,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now!',
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