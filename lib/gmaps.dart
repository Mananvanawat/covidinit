import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMaps extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
 var latitude, longitude;
class _MyAppState extends State<GMaps> {
  Completer<GoogleMapController> _controller = Completer();



  @override
  Widget build(BuildContext context) {
    void setTheLatLong(var lat, var long) {
      setState(() {
        longitude = long;
        latitude = lat;
      });
    }

    Future<void> getCurrentPosition() async {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

      var lat = position.latitude;
      var long = position.longitude;
      setTheLatLong(lat, long);
      GoogleMapController controller = await _controller.future;
      print('called');
      controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(latitude, longitude), zoom: 18)));

    }

    void _onCameraMove(CameraPosition P) {
      setTheLatLong(
          P.target.latitude, P.target.longitude);
    }

    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
  title: Text("Set your location"),
  actions: <Widget>[
    IconButton(icon: Icon(Icons.done,color: Colors.white ,), onPressed: (){Navigator.of(context).pop();})
  ],
),
      body: GoogleMap(
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(target: LatLng(24, 73), zoom: 25),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onCameraMove: _onCameraMove,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.gps_fixed),
          backgroundColor: Colors.green,
          onPressed: () {

        getCurrentPosition();
      }),
    ));
  }
}
