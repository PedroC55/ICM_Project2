import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:homework/Models/usermodel.dart';
import 'package:homework/login.dart';
import 'package:homework/main.dart';
import 'package:homework/utils.dart';

class SignUpWidget extends StatefulWidget{

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget>{
  final formkey = GlobalKey<FormState>();
  final email_controller = TextEditingController();
  final pass_controller = TextEditingController();
  final name_controller = TextEditingController();
  final age_controller = TextEditingController();
  final phonenumber_controller = TextEditingController();
  final nmec_controller = TextEditingController();


  @override
  void dispose(){
    email_controller.dispose();
    pass_controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    return  Scaffold(
      body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: formkey,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40),
          TextFormField(
            controller: email_controller,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "E-mail"),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) => 
              email != null && !EmailValidator.validate(email)
              ? 'Enter valid E-mail!'
              : null,
          ),
          SizedBox(
            height: 4),
          TextFormField(
            obscureText: true,
            controller: pass_controller,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "Password"),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => 
              value != null && value.length < 6
              ? 'Enter a valid password (6 characters minimum)!'
              : null,
          ),
          SizedBox(
            height: 4),
          TextFormField(
            controller: name_controller,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "Name"),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => 
              value == null
              ? 'Enter your name!'
              : null,
          ),
          SizedBox(
            height: 4),
          TextFormField(
            controller: age_controller,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "Age"),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => 
              value == null 
              ? 'Enter your age!'
              : null,
          ),
          SizedBox(
            height: 4),
          TextFormField(
            controller: phonenumber_controller,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "Phone Number"),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => 
              value == null
              ? 'Enter your phone number!'
              : null,
          ),
          SizedBox(
            height: 4),
          TextFormField(
            controller: nmec_controller,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "NMEC"),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => 
              value == null || value.length != 5
              ? 'Enter your NMEC!'
              : null,
          ),
          SizedBox(height: 20,),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ),
            onPressed: signup, 
            icon: Icon(Icons.lock_open, size: 32,),
            label: Text("Sign Up", style: TextStyle(fontSize: 24),)
          ),
          SizedBox(height: 24,),
          RichText(text: TextSpan(
            style: TextStyle(color: Colors.blue, fontSize: 20),
            text: "Already have an account? ",
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginWidget()),
                                );
                              },
                text: "Login",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.secondary,
                )
              )
            ]
          ))
        ],
        
      ),
      ) 
      
      ),
    );
    
  } 
  Future signup() async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;


    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) => Center(child: CircularProgressIndicator(color: Colors.blue),));
    try{
      var data = UserModel(name_controller.text, email_controller.text, pass_controller.text, int.parse(age_controller.text), int.parse(phonenumber_controller.text), int.parse(nmec_controller.text), "");
      
      FirebaseFirestore.instance.collection("users").add(data.toJson());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email_controller.text.trim(), password: pass_controller.text.trim());
    } catch (e){
      print(e);
      Utils().showSnackBar(e.toString());
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}