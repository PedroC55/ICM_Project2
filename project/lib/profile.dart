import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget{
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context){


    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc.data());
      });
    })
    .catchError((error) {
      print(error);
    });
    /*
    getUser() async {
      await db.collection("users").get().then((event) {
        print("HEYYYYYY");
        for (var doc in event.docs) {
          print("${doc.id} => ${doc.data()}");
        }
      });
    }

    getUser();*/

    return Center(child: Text("Profile Tab"));
    
  }

}

