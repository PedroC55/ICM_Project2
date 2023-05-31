import 'package:flutter/material.dart';
import 'eventsdetails.dart';
import 'package:homework/eventsdetails.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class EventsWidget extends StatefulWidget{
 Events createState() => Events();
}


class Events extends State<EventsWidget> {
  final List<String> items = List<String>.generate(50, (i) => "Item $i");
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Scaffold(
         body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    backgroundColor: Colors.red,
                    icon: Icons.delete_forever_outlined,
                    label: "Delete Event", 
                    onPressed: (context) => _OnDismissed(index),  
                  )
              ],
              ),
              child:ListTile(
              title: Text(items[index]),
              trailing: Icon(Icons.arrow_circle_up),
              contentPadding: EdgeInsets.all(20),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => EventsDetails(index: items[index],)));
            },
            ), 
            );
          },
        ),
      ),
    );
  }
  void _OnDismissed(int index){
    setState(() => items.removeAt(index));
  }

}
