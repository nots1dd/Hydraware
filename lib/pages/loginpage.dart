

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hydraware/components/button.dart';
import 'package:hydraware/components/pwdtextfield.dart';
import 'package:hydraware/components/squaretile.dart';
import 'package:hydraware/components/textfield.dart';
import 'package:hydraware/services/authservice.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //final PwdTextField passwordController = PwdTextField();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPassword = true;

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
        email: emailController.text.trim(), 
        password: passwordController.text.trim()
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
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(8),),
        child: Center(
          child: Text('Email invalid or unregistered!', style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
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
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(8),),
        child: Center(
          child: Text('Invalid password!', style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
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
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(8),),
        child: Center(
          child: Text('Something went wrong! Try again!!', style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16)),
        ),
        ),
         
      );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(context, '/')
                  },
                  child: Lottie.asset('lib/images/Hydraware_animation_2.json', width: 140, height: 140)), //TODO: Change logo to Hydraware logo
                const SizedBox(height: 30),
                Text('Welcome back!', style: TextStyle(color: Colors.blue[300],fontSize: 16,fontWeight: FontWeight.bold )),
                const SizedBox(height: 25),
                MyTextField(controller: emailController,hintText: 'Enter mail ID',obscureText: false,),
                const SizedBox(height: 10),
                //MyTextField(controller: passwordController,hintText: 'Enter password',obscureText: true,), //textfield.dart for config
                pwdTextField(controller: passwordController, hintText: 'Enter Password', isPassword: isPassword), //pwdtextfield.dart for config
                
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

                MyButton(onTap: signUserIn, text: 'Log In!',),
            
                const SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(child: Divider(thickness: 0.75,color: Colors.grey[550],)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Theme.of(context).colorScheme.tertiary,fontWeight: FontWeight.bold),),
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
                    Text('Not a member?',style: TextStyle(color: Theme.of(context).colorScheme.tertiary,fontWeight: FontWeight.bold)),
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