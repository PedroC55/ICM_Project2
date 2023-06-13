import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:homework/Models/usermodel.dart';
import 'package:homework/login.dart';
import 'package:homework/main.dart';
import 'package:homework/utils.dart';

class EditProfileWidget extends StatefulWidget{

  @override
  _EditProfileWidget createState() => _EditProfileWidget();
}



class _EditProfileWidget extends State<EditProfileWidget>{
  final formkey = GlobalKey<FormState>();
  final email_controller = TextEditingController();
  final pass_controller = TextEditingController();
  final name_controller = TextEditingController();
  final age_controller = TextEditingController();
  final phonenumber_controller = TextEditingController();
  final nmec_controller = TextEditingController();
  String _userName = "";
  String id = "";
  @override
  void dispose(){
    email_controller.dispose();
    pass_controller.dispose();
    super.dispose();
  }

    void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _getUserName();
    });
    super.initState();
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
            onPressed: edit, 
            icon: Icon(Icons.edit_rounded, size: 32,),
            label: Text("Edit Profile", style: TextStyle(fontSize: 24),)
          ),
        ],
        
      ),
      ) 
      
      ),
    );
    
  } 
  Future edit() async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;


    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) => Center(child: CircularProgressIndicator(color: Colors.blue),));
    try{
      var data = UserModel(name_controller.text, email_controller.text, pass_controller.text, int.parse(age_controller.text), int.parse(phonenumber_controller.text), int.parse(nmec_controller.text), "");
      _getUserName();
      FirebaseFirestore.instance.collection("users").doc(id).update(data.toJson());
    } catch (e){
      print(e);
      Utils().showSnackBar(e.toString());
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  _getUserName() async {
    _userName = ((await FirebaseAuth.instance.currentUser()).email);
    final userDoc = await FirebaseFirestore.instance.collection("users").get().then((value){
      value.docs.forEach((element) async {
        if (_userName == element['email']){
          id = element.id.toString();
        }
      });
      
    });
    
  }
}