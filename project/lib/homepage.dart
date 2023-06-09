import 'package:flutter/material.dart';
import 'package:homework/events.dart';
import 'package:homework/qr_code_scanner.dart';

import 'map.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, 
      child: Scaffold(appBar: AppBar(title: Text("MovingCampus"))
      ,body: Column(
        children: [
          TabBar(
            labelStyle: TextStyle(fontSize: 10), 
            tabs: [
              Tab(icon: Icon(Icons.home, color: Colors.amber,), text: "Events" ),
              Tab(icon: Icon(Icons.maps_home_work, color: Colors.amber,), text: "Location"),
              Tab(icon: Icon(Icons.qr_code_2, color: Colors.amber,), text: "QR Code"),
              Tab(icon: Icon(Icons.person, color: Colors.amber,), text: "Profile"),
          ]),
          Expanded
          (
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
              EventsWidget(),
              MapPage(),
              QRCodePage(),
              Container(child: 
                Center(child: Text("Profile Tab")),)
            ]),
          )
      ],),
      
      ));
  }
}
