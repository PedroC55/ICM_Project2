import 'package:flutter/material.dart';
import "package:flutter_map/flutter_map.dart";
import 'package:map_markers/map_markers.dart';
import "package:latlong/latlong.dart";
import "package:http/http.dart" as http;
import "dart:convert" as convert;

class MapPage extends StatelessWidget {
  final String apiKey = "uQpFMcxisuAQAN46ttbJmtorIczOhYPC";
  final List<Marker> markers = List.empty(growable: true);


  @override
  Widget build(BuildContext context) {
    final tomtomHQ = new LatLng(40.63063617601428, -8.657445837630856);

    final initialMarker =
      new Marker(
        width: 50.0,
        height: 50.0,
        point: tomtomHQ,
        builder: (BuildContext context) => const Icon(
            Icons.room_service,
            size: 20.0,
            color: Colors.red),
      );
    markers.add(initialMarker);

    

    getAddresses(value, lat, lon) async {
      final Map<String,String> queryParameters = {'key': '$apiKey'};
      queryParameters['lat'] = '$lat';
      queryParameters['lon'] = '$lon';
      var response = await http.get( Uri.https('api.tomtom.com',
        '/search/2/search/$value.json',
        queryParameters));
      var jsonData = convert.jsonDecode(response.body);
      print('$jsonData');
      var results = jsonData['results'];
      for ( var element in results) {
        var position = element['position'];
         var marker = new Marker(
          point: new LatLng(position['lat'], position['lon']),
          width: 50.0,
          height: 50.0,
          builder: (BuildContext context) => const Icon(
              Icons.location_on,
              size: 40.0,
              color: Colors.blue),
        );
        markers.add(marker);
      }

    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TomTom Map",
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(

            child: Stack(
              children: <Widget>[
                FlutterMap(
                  options: new MapOptions(center: tomtomHQ, zoom: 16.0),
                  layers: [
                    new TileLayerOptions(
                      urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                          "{z}/{x}/{y}.png?key={apiKey}",
                      additionalOptions: {"apiKey": apiKey},
                    ),

                     new MarkerLayerOptions(
                      markers: markers,
                    ),
                    
                  ],
                ),
                Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.bottomLeft,
                    child: Icon(Icons.map_rounded)),
                Container(
                  padding: EdgeInsets.all(30),
                  alignment: Alignment.topRight,
                  child: TextField(
                    onSubmitted: (value) {
                      print('$value');
                      getAddresses(value, tomtomHQ.latitude, tomtomHQ.longitude);
                    },
                  )
                )

              ],
            )),
      ),
    );
  }
}