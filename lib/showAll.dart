import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class SeeAll extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<SeeAll> {
  Set<Marker> _markers = {};




  Completer<GoogleMapController> _controller = Completer();
  void retrive() {
    Firestore.instance
        .collection('requests')
        .where("Status", isEqualTo: "pending")
        .snapshots()
        .listen(
          (data) => data.documents.forEach(
            (doc) {
          setState(() {
            _markers.add(Marker(
                markerId: MarkerId(doc['Uid']),
                 position: LatLng(doc['Latitude'], doc['Longitude'])


            ));
          });
        },
      ),
    );
  }

  @override
  void initState() {
    retrive(); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
            CameraPosition(target: LatLng(24, 73), zoom: 17),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ));
  }
}
