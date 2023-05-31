import 'package:flutter/material.dart';
import 'eventsdetails.dart';

class EventsDetails extends StatelessWidget {
  const EventsDetails({super.key, required this.index});
  final String index;
  

  @override
  Widget build(BuildContext context) {
    String a = index;
    return Scaffold(
      appBar: AppBar(title: Text("MovingCampus")),
      body: 
        Center(
          child:Text("Detalhes do evento $index", style: TextStyle(fontSize: double.parse(a.split(" ")[1])+1.0)),    
        )
    );      
  }
}
