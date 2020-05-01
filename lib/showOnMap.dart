import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class showOnMap extends StatefulWidget {
  var latitude, longitude;

  showOnMap(var lat, var long) {
    latitude = lat;
    longitude = long;
  }

  @override
  _MyAppState createState() => _MyAppState(latitude, longitude);
}

class _MyAppState extends State<showOnMap> {
  Set<Marker> _markers = {};
  var latitude, longitude;

  _MyAppState(var lat, var long) {
    longitude = long;
    latitude = lat;
  }

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    _markers.add(Marker(
        markerId: MarkerId('marker1'), position: LatLng(latitude, longitude)));
    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Colors.redAccent,
        title: Text("Location"),
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        markers: _markers,
        initialCameraPosition:
            CameraPosition(target: LatLng(latitude, longitude), zoom: 17),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    ));
  }
}
