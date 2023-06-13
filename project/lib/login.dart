import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:homework/main.dart';
import 'package:homework/signuppage.dart';
import 'package:homework/utils.dart';

class LoginWidget extends StatefulWidget{
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget>{
  final email_controller = TextEditingController();
  final pass_controller = TextEditingController();

  @override
  void dispose(){
    email_controller.dispose();
    pass_controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40),
          Image(image: AssetImage('assets/campusapp_high_resolution_color_logo.png')),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: email_controller,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "E-mail"),
          ),
          SizedBox(
            height: 4),
          TextField(
            obscureText: true,
            controller: pass_controller,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "Password"),
          ),
          SizedBox(height: 20,),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ),
            onPressed: signin, 
            icon: Icon(Icons.lock_open, size: 32,),
            label: Text("Sign In", style: TextStyle(fontSize: 24),)
          ),
          SizedBox(height: 24,),
          RichText(text: TextSpan(
            style: TextStyle(color: Colors.blue, fontSize: 20),
            text: "No Account? ",
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUpWidget()),
                                );
                              },
                text: "Sign Up",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.secondary,
                )
              )
            ]
          ))
        ],
        
      )
    ),
    ); 
    
  } 
  Future signin() async {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) => Center(child: CircularProgressIndicator(color: Colors.blue),));
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email_controller.text.trim(), password: pass_controller.text.trim());
    } on FirebaseException catch (e){
      print(e);
      Utils().showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}