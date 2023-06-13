import 'package:flutter/material.dart';

class Utils{
  final messengerKey = GlobalKey<ScaffoldMessengerState>();

  showSnackBar(String? text){
    if(text == null) return;
    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.red,);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}