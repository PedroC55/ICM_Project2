import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'eventsdetails.dart';
import 'package:homework/eventsdetails.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class EventsWidget extends StatefulWidget{
 Events createState() => Events();
}


class Events extends State<EventsWidget> {
  List<String> names = [];
  List<String> ids = [];

  int peddyLength = 0;
  final fire = FirebaseFirestore.instance;
  

  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getPeddyPapers();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    fire.settings = const Settings(persistenceEnabled: true, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,);
    return Container(
      child: Scaffold(
         body: FutureBuilder(
          future: getPeddyPapers(),
          builder: (context, snapshot){
            return ListView.builder(
          itemCount: peddyLength,
          itemBuilder: (context, index) {
            return Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
              ],
              ),
              child:ListTile(
              title: Text(names[index]),
              trailing: Icon(Icons.arrow_circle_up),
              contentPadding: EdgeInsets.all(20),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => EventsDetails(index: ids[index])));
            },
            ), 
            );
          } 
          
          ,);
          }         
         
         
        ),
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
  }

  getPeddyPapers() async {
    final userDoc = await fire.collection("peddypaper").get().then((value){
      peddyLength =value.docs.length;
      value.docs.forEach((element) async {
        names.add(element['name']);
        ids.add(element.id);
        });
    });
  }
}
