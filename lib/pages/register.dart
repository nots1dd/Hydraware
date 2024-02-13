

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hydraware/components/button.dart';
import 'package:hydraware/components/pwdtextfield.dart';
import 'package:hydraware/components/squaretile.dart';
import 'package:hydraware/components/textfield.dart';
import 'package:hydraware/services/authservice.dart';
import 'package:lottie/lottie.dart';

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
  bool isPassword = true;

  void invalidAuth(String message) {

    showDialog(
      context: context, 
      builder: (context) {
        return Dialog(
        child: Container(
          width: 30,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(8),),
        child: Center(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(message, style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 16)),
          ),
        ),
        ),
         
      );
        },
        );
  }

  void mailCheck() {
    RegExp regExp = RegExp(r"@(?:gmail|yahoo|hotmail)\.com$");
    if (regExp.hasMatch(emailController.text.trim()) == false){
      invalidAuth('Please enter a mail ID');
    }
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
      RegExp regExp = RegExp(r"@(?:gmail|yahoo|hotmail)\.com$");
      if (regExp.hasMatch(emailController.text.trim()) == false){
      Navigator.pop(context);
      invalidAuth('Please enter a mail ID');
      return;
      }
       if(passwordController.text.trim() != confirmpasswordController.text.trim()) {
        Navigator.pop(context);
        invalidAuth("Passwords do not match");
      return;
    }
      if (passwordController.text.trim() == confirmpasswordController.text.trim()) { //TODO: check for mail domains thru regex (any domain is able to login now)
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(), 
        password: passwordController.text.trim()
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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(context, '/')
                  },
                  child: Lottie.asset('lib/images/Hydraware_animation_2.json', width: 130, height: 130)),
                const SizedBox(height: 20),
                Text('Welcome to Hydraware!', style: TextStyle(color: Colors.blue[300],fontSize: 16,fontWeight: FontWeight.bold)),
                const SizedBox(height: 25),
                MyTextField(controller: emailController,hintText: 'Enter mail ID',obscureText: false,),
                const SizedBox(height: 10),
                pwdTextField(controller: passwordController, hintText: 'Enter your password', isPassword: isPassword), //textfield.dart for config
                const SizedBox(height: 10),
                pwdTextField(controller: confirmpasswordController, hintText: 'Confirm password', isPassword: isPassword),
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
                    Text('Already a member?',style: TextStyle(color: Theme.of(context).colorScheme.tertiary,fontWeight: FontWeight.bold)),
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