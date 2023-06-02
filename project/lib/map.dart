import "dart:convert";
import "dart:js_util";

import "package:flutter/gestures.dart";
import 'package:flutter/material.dart';
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart";
import "package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart";
import "package:flutter_polyline_points/flutter_polyline_points.dart";
import 'package:map_markers/map_markers.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import "package:latlong/latlong.dart";
import "package:http/http.dart" as http;
import "dart:convert" as convert;
import 'example_popup.dart';


class MapPage extends StatelessWidget {
  final String apiKey = "uQpFMcxisuAQAN46ttbJmtorIczOhYPC";
  final List<Marker> markers = List.empty(growable: true);
  final List<String> depts = List.empty(growable: true);


  @override
  Widget build(BuildContext context) {
    final PopupController _popupController = PopupController();
    final ua = new LatLng(40.63063617601428, -8.657445837630856);
    //final deti = new LatLng(40.63317591846193, -8.659494546730407);
    //final reitoria = new LatLng(40.63135360702917, -8.657449692844947);
    String findMarker(Marker m) {
      for(int i = 0; i < markers.length; i++){
        if(markers.elementAt(i).point == m.point){
          return depts.elementAt(i);
        }  
      }
      return " ";
    }

    var latL = [];
    var lonL = [];
    
    List<LatLng> polyCoordinates = [];

    void getPolyPoints() async {
      PolylinePoints polypoints = PolylinePoints();
      //PolylineResult result = polypoints.getRouteBetweenCoordinates(apiKey, PointLatLng(ua.latitude, ua.longitude), const PointLatLng(40.552196, -8.686077), travelMode: TravelMode.walking);
      var  ori_lat = ua.latitude;
      var ori_lon = ua.longitude;
      var dest_lat = 40.552196;
      var dest_lon = -8.686077;
      final res = await http.get(Uri.parse('https://api.tomtom.com/routing/1/calculateRoute/' + '$ori_lat' + '%2C' + '$ori_lon' + '%3A' + '$dest_lat' + '%2C' + '$dest_lon' + '/json?computeBestOrder=true&routeRepresentation=polyline&sectionType=pedestrian&travelMode=pedestrian&key=uQpFMcxisuAQAN46ttbJmtorIczOhYPC'));
      print(json.decode(res.body)['routes'][0]['legs'][0]['points'][0]);
      /*
      for(var p in json.decode(res.body)['routes'][0]['legs'][0]['points']){
        latL.add(p['latitude']);
        lonL.add(p['longitude']);
      }*/
    }
    
    getPolyPoints();

    final deti =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.63317591846193, -8.659494546730407),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final reitoria =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.63135360702917, -8.657449692844947),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );

    final dbio =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.63380844264432, -8.659319462526593),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    
    final psi =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.63182805953909, -8.658864860099207),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );

    final degeit =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.630880306269695, -8.656999188889994),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    
    final dmat =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.630418129607875, -8.658197920184241),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final essua =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.6235935159463, -8.657460978613498),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final casaEst =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.623866678205154, -8.657312103521186),
        builder: (BuildContext context) => const Icon(
            Icons.groups_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final cantinaCrasto =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.62447122149206, -8.656821947720015),
        builder: (BuildContext context) => const Icon(
            Icons.food_bank_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final residencias =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.63232334279521, -8.655852417698153),
        builder: (BuildContext context) => const Icon(
            Icons.apartment_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final restauranteUni =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.631258921278736, -8.65557516626951),
        builder: (BuildContext context) => const Icon(
            Icons.food_bank_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final isca =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.63062465540277, -8.653337438511986),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final estga =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.57467735207429, -8.443419074739488),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final esan =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.8622535929045, -8.476219335824565),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final meca =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.630021263651315, -8.657528827736456),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final meialua =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.62956644327867, -8.656410184497393),
        builder: (BuildContext context) => const Icon(
            Icons.groups_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final civil =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.62978991586072, -8.657206782531778),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final artes =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.62899942110188, -8.65628433654733),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final cp =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.62934816993908, -8.655123620379278),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final cantina =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.630603650689594, -8.659099328532545),
        builder: (BuildContext context) => const Icon(
            Icons.food_bank_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final fotossintese =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.63146706467744, -8.658989206042046),
        builder: (BuildContext context) => const Icon(
            Icons.groups_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final pavilhao =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.62985965801426, -8.654152146349025),
        builder: (BuildContext context) => const Icon(
            Icons.sports_basketball_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final linguas =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.63530943837447, -8.657699549544633),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final cesam =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.63485708694915, -8.657525510585096),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final amb =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.632537172829814, -8.659154323844664),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final demac =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.634351912083034, -8.658738378468893),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final dcspt =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.62994174144051, -8.65824984251955),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final dfis =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.63027458509032, -8.656960124641419),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final dq =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.63004248986769, -8.65587054457578),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );
    final dgeo =
      new Marker(
        width: 20.0,
        height: 20.0,
        point: new LatLng(40.62960429902085, -8.656971448564825),
        builder: (BuildContext context) => const Icon(
            Icons.account_balance_rounded,
            size: 20.0,
            color: Colors.black),
      );

    markers.add(deti);
    depts.add("Department\nDETI");
    markers.add(reitoria);
    depts.add("Department\nDean's Office");
    markers.add(dbio);
    depts.add("Department\nDBIO");
    markers.add(psi);
    depts.add("Department\nDEP");
    markers.add(degeit);
    depts.add("Department\nDEGEIT");
    markers.add(dmat);
    depts.add("Department\nDMAT");
    markers.add(essua);
    depts.add("Department\nESSUA");
    markers.add(casaEst);
    depts.add("Social Place\nBE");
    markers.add(cantinaCrasto);
    depts.add("Canteen\nCantina do Crasto");
    markers.add(cantina);
    depts.add("Canteen\nCantina de Santiago");
    markers.add(residencias);
    depts.add("Residences\nResidências de Santiago");
    markers.add(restauranteUni);
    depts.add("Canteen\nRestaurante Universitário");
    markers.add(dgeo);
    depts.add("Department\nDGEO");
    markers.add(dq);
    depts.add("Department\nDQ");
    markers.add(dcspt);
    depts.add("Department\nDCSPT");
    markers.add(demac);
    depts.add("Department\nDEMAC");
    markers.add(dfis);
    depts.add("Department\nDFIS");
    markers.add(isca);
    depts.add("Department\nISCA");
    markers.add(esan);
    depts.add("Department\nISAN");
    markers.add(estga);
    depts.add("Department\nESTGA");
    markers.add(meca);
    depts.add("Department\nDEM");
    markers.add(meialua);
    depts.add("Social Place\nMeia Lua");
    markers.add(civil);
    depts.add("Department\nDEC");
    markers.add(artes);
    depts.add("Department\nDeCA");
    markers.add(cp);
    depts.add("Department\nCP");
    markers.add(cesam);
    depts.add("Department\nCESAM");
    markers.add(fotossintese);
    depts.add("Social Place\nFotossíntese");
    markers.add(pavilhao);
    depts.add("Sports Facility\nPavilhão Aristides Hall");
    markers.add(linguas);
    depts.add("Department\nDLC");
    markers.add(amb);
    depts.add("Department\nDAO");

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
                  options: new MapOptions(center: ua, zoom: 16.0, 
                    plugins: [MarkerClusterPlugin(),],
                    onTap: (_) => _popupController
                      .hidePopup(), 
                  ),
                  layers: [
                    new TileLayerOptions(
                      urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                          "{z}/{x}/{y}.png?key={apiKey}",
                      additionalOptions: {"apiKey": apiKey},
                    ),
                    TappablePolylineLayerOptions(
                      polylineCulling: true,
                      polylines: [TaggedPolyline(points: [
                        for(var lat in latL) LatLng(lat,lonL[latL.indexOf(lat)])
                      ],)],       
                      onTap: (TaggedPolyline polyline) => print(polyline.tag),
                      onMiss: () => print("No polyline tapped"),
                    ),
                    MarkerClusterLayerOptions(
                      maxClusterRadius: 190,
                      disableClusteringAtZoom: 16,
                      size: const Size(50, 50),
                      fitBoundsOptions: const FitBoundsOptions(
                        padding: EdgeInsets.all(50),
                      ),
                      markers: markers,
                      polygonOptions: const PolygonOptions(
                          borderColor: Colors.blueAccent,
                          color: Colors.black12,
                          borderStrokeWidth: 3),
                      builder: (context, markers) {
                        return Container(
                          alignment: Alignment.center,
                          decoration:
                              const BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
                          child: Text('${markers.length}'),

                        );
                      },
                      popupOptions: PopupOptions(
                        popupSnap: PopupSnap.top,
                        popupController: _popupController,
                        popupBuilder: (_, marker) => Container(
                          alignment: Alignment.center,
                            height: 50,
                            width: 100,
                            decoration: const BoxDecoration(
                                color: Colors.amber, shape: BoxShape.rectangle),
                            child: Text(
                              findMarker(marker).toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                      ),
                    ),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.bottomLeft,
                    child: const Icon(Icons.map_rounded)),
                Container(
                  padding: const EdgeInsets.all(30),
                  alignment: Alignment.topRight,
                  child: TextField(
                    onSubmitted: (value) {
                      print('$value');
                      getAddresses(value, ua.latitude, ua.longitude);
                    },
                  )
                )

              ],
            )),
      ),
    );
  }
}

class PopupMarkerLayer {
}