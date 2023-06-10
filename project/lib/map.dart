import "dart:convert";

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
import 'package:geolocator/geolocator.dart';



class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage>{
  final String apiKey = "uQpFMcxisuAQAN46ttbJmtorIczOhYPC";
  List<Marker> _markers = List.empty(growable: true);
  final List<Marker> markers2 = List.empty(growable: true);
  final List<String> depts = List.empty(growable: true);
  LatLng _currentPos = new LatLng(0, 0);
  List<TaggedPolyline> _polylines = <TaggedPolyline>[];


  @override
  Widget build(BuildContext context) {
    PopupController _popupController = PopupController();
    TextEditingController textarea = new TextEditingController();
    final ua = new LatLng(40.63063617601428, -8.657445837630856);
    
    //final deti = new LatLng(40.63317591846193, -8.659494546730407);
    //final reitoria = new LatLng(40.63135360702917, -8.657449692844947);
    String findMarker(Marker m) {
      for(int i = 0; i < markers2.length; i++){
        if(markers2.elementAt(i).point == m.point){
          return depts.elementAt(i);
        }  
      }
      return " ";
    }
/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
    /*
    Future<LatLng> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the 
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale 
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately. 
        return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
      } 

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      LatLng userlatlng = new LatLng(pos.latitude, pos.longitude);
      _currentPos = userlatlng;
      return Future.delayed(const Duration(seconds: 2), () => userlatlng);
    }*/


    var latL = [];
    var lonL = [];
    
    List<LatLng> polyCoordinates = [];
    void getPolyPoints(userLoc, searchLoc) async {
      print(userLoc);
      print(searchLoc);
      var  ori_lat = userLoc.latitude;
      var ori_lon = userLoc.longitude;
      var dest_lat = searchLoc.latitude;
      var dest_lon = searchLoc.longitude;
      final res = await http.get(Uri.parse('https://api.tomtom.com/routing/1/calculateRoute/' + '$ori_lat' + '%2C' + '$ori_lon' + '%3A' + '$dest_lat' + '%2C' + '$dest_lon' + '/json?computeBestOrder=true&routeRepresentation=polyline&sectionType=pedestrian&travelMode=pedestrian&key=uQpFMcxisuAQAN46ttbJmtorIczOhYPC'));
      print(json.decode(res.body)['routes'][0]['legs'][0]['points'][0]['latitude']);
      
      for(var p in json.decode(res.body)['routes'][0]['legs'][0]['points']){
        latL.add(p['latitude']);
        lonL.add(p['longitude']);
        polyCoordinates.add(LatLng(p['latitude'], p['longitude']));
      }
      setState(() {
        _polylines = [TaggedPolyline(points: polyCoordinates, strokeWidth: 10.0, color: Colors.blue)];
      }); 
    }

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

    markers2.add(deti);
    depts.add("Department\nDETI");
    markers2.add(reitoria);
    depts.add("Department\nDean's Office");
    markers2.add(dbio);
    depts.add("Department\nDBIO");
    markers2.add(psi);
    depts.add("Department\nDEP");
    markers2.add(degeit);
    depts.add("Department\nDEGEIT");
    markers2.add(dmat);
    depts.add("Department\nDMAT");
    markers2.add(essua);
    depts.add("Department\nESSUA");
    markers2.add(casaEst);
    depts.add("Social Place\nBE");
    markers2.add(cantinaCrasto);
    depts.add("Canteen\nCantina do Crasto");
    markers2.add(cantina);
    depts.add("Canteen\nCantina de Santiago");
    markers2.add(residencias);
    depts.add("Residences\nResidências de Santiago");
    markers2.add(restauranteUni);
    depts.add("Canteen\nRestaurante Universitário");
    markers2.add(dgeo);
    depts.add("Department\nDGEO");
    markers2.add(dq);
    depts.add("Department\nDQ");
    markers2.add(dcspt);
    depts.add("Department\nDCSPT");
    markers2.add(demac);
    depts.add("Department\nDEMAC");
    markers2.add(dfis);
    depts.add("Department\nDFIS");
    markers2.add(isca);
    depts.add("Department\nISCA");
    markers2.add(esan);
    depts.add("Department\nISAN");
    markers2.add(estga);
    depts.add("Department\nESTGA");
    markers2.add(meca);
    depts.add("Department\nDEM");
    markers2.add(meialua);
    depts.add("Social Place\nMeia Lua");
    markers2.add(civil);
    depts.add("Department\nDEC");
    markers2.add(artes);
    depts.add("Department\nDeCA");
    markers2.add(cp);
    depts.add("Department\nCP");
    markers2.add(cesam);
    depts.add("Department\nCESAM");
    markers2.add(fotossintese);
    depts.add("Social Place\nFotossíntese");
    markers2.add(pavilhao);
    depts.add("Sports Facility\nPavilhão Aristides Hall");
    markers2.add(linguas);
    depts.add("Department\nDLC");
    markers2.add(amb);
    depts.add("Department\nDAO");


    _markers = markers2;

    Future<LatLng> getUserLocation() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are disabled, handle accordingly
        //return;
      }

      // Check location permission status
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Location permissions are denied, request permission
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Location permissions are still denied, handle accordingly
          //return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Location permissions are permanently denied, handle accordingly
        //return;
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition();
      _currentPos = new LatLng(position.latitude, position.longitude);
      return  LatLng(position.latitude, position.longitude);
    }
    getAddresses(value, lat, lon) async {
      LatLng ponto = new LatLng(0, 0);
      String pos = value.toString();
      if(pos.substring(0,2).contains("04")){
        ponto = deti.point;
      }
      if(pos.substring(0,2).contains("02")){
        ponto = linguas.point;
      }
      if(pos.substring(0,2).contains("03")){
        ponto = cesam.point;
      }
      if(pos.substring(0,2).contains("25") || pos.toString().toLowerCase().contains("reitoria")){
        ponto = reitoria.point;
      }
      if(pos.substring(0,2).contains("08")){
        ponto = dbio.point;
      }
      if(pos.substring(0,2).contains("09")){
        ponto = demac.point;
      }
      if(pos.substring(0,2).contains("05")){
        ponto = psi.point;
      }if(pos.substring(0,2).contains("10")){
        ponto = degeit.point;
      }if(pos.substring(0,2).contains("11")){
        ponto = dmat.point;
      }if(pos.substring(0,2).contains("30")){
        ponto = essua.point;
      }if(pos.substring(0,1).contains("N") || pos.toString().toLowerCase().contains("casa do estudante") || pos.toString().toLowerCase().contains("be")){
        ponto = casaEst.point;
      }if(pos.substring(0,1).contains("M") || pos.toString().toLowerCase().contains("cantina do crasto")){
        ponto = cantinaCrasto.point;
      }if(pos.substring(0,1).contains("6") || pos.toString().toLowerCase().contains("cantina de santiago")){
        ponto = cantina.point;
      }if(pos.substring(0,1).contains("B") || pos.toString().toLowerCase().contains("residências")){
        ponto = residencias.point;
      }if(pos.substring(0,1).contains("F") || pos.toString().toLowerCase().contains("restaurante")){
        ponto = restauranteUni.point;
      }if(pos.substring(0,2).contains("16")){
        ponto = dgeo.point;
      }if(pos.substring(0,2).contains("15")){
        ponto = dq.point;
      }if(pos.substring(0,2).contains("12")){
        ponto = dcspt.point;
      }if(pos.substring(0,2).contains("13")){
        ponto = dfis.point;
      }if(pos.substring(0,2).contains("35")){
        ponto = isca.point;
      }if(pos.substring(0,2).contains("34")){
        ponto = esan.point;
      }if(pos.substring(0,2).contains("20")){
        ponto = estga.point;
      }if(pos.substring(0,2).contains("22")){
        ponto = meca.point;
      }if(pos.toString().toLowerCase().contains("meia lua")){
        ponto = meialua.point;
      }if(pos.substring(0,2).contains("28")){
        ponto = civil.point;
      }if(pos.substring(0,2).contains("21")){
        ponto = artes.point;
      }if(pos.substring(0,2).contains("23")){
        ponto = cp.point;
      }if(pos.toString().toLowerCase().contains("fotossintese")){
        ponto = fotossintese.point;
      }if(pos.toString().toLowerCase().contains("pavilhão")){
        ponto = pavilhao.point;
      }if(pos.substring(0,2).contains("07")){
        ponto = amb.point;
      }
      getUserLocation();
      getPolyPoints(_currentPos, ponto);
    }
    getUserLocation();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TomTom Map",
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Stack(
              children: <Widget>[
                FlutterMap(
                  options: MapOptions(center: ua , zoom: 16.0, 
                    plugins: [MarkerClusterPlugin(),],
                    onTap: (_) => _popupController
                      .hidePopup(),
                    onLongPress: (_) => setState(() {
                      _polylines.clear();
                    }),
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                          "{z}/{x}/{y}.png?key={apiKey}",
                      additionalOptions: {"apiKey": apiKey},
                    ),
                    
                    TappablePolylineLayerOptions(
                      polylineCulling: true,
                      polylines: _polylines,       
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
                      markers: _markers,
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
                    controller: textarea,
                    onSubmitted: (value) {
                      print('$value');
                      getAddresses(value, ua.latitude, ua.longitude);
                      textarea.clear();
                    },
                  )
                )

              ],
            )),
      ),
    );
  }
}