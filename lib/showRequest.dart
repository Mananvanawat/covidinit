

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidinit/showAll.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'showOnMap.dart';

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Change It',
      home: PendingRequests(),
    );
  }
}

class PendingRequests extends StatefulWidget {
  @override
  _PendingRequestsState createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  final List<Requests> pendingRequests = [];

  void retrive() {
    Firestore.instance
        .collection('requests')
        .where("Status", isEqualTo: "pending")
        .snapshots()
        .listen(
          (data) => data.documents.forEach(
            (doc) {
              setState(() {
                pendingRequests.add(Requests(
                  address: doc['Address'].toString(),
                  latitude: doc['Latitude'],
                  longitude: doc['Longitude'],
                  name: doc['Name'].toString(),
                  phone: doc['Phone'].toString(),
                  type: doc['Type'].toString(),
                  uid: doc['UID'].toString(),
                  st:'Mark as complete'
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

  DocumentSnapshot _currentDocument;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.map),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SeeAll()));
          },

        ),
        appBar: AppBar(
          title: Center(child: Text('Pending Requests')),
          backgroundColor: Colors.redAccent,
        ),
        body: ListView.builder(
          itemCount: pendingRequests.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Name : ' +
                                pendingRequests[index].name.toUpperCase(),
                            textAlign: TextAlign.start,
                            style: GoogleFonts.abel(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Waste Type: ' +
                                pendingRequests[index].type.toUpperCase(),
                            textAlign: TextAlign.left,
                            style: GoogleFonts.abel(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Contact: ' + pendingRequests[index].phone,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.abel(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Address: ' + pendingRequests[index].address,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.abel(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      )),
                      Expanded(
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: RaisedButton(
                                onPressed: (){
                                    setState(() {
                                      pendingRequests[index].st='Completed';
                                    });
                                },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16))
                                    ),
                                child: Text(
                                  pendingRequests[index].st
                                ),
                                color: Colors.green[200],
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(16))
                                    ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => showOnMap(
                                              pendingRequests[index].latitude,
                                              pendingRequests[index]
                                                  .longitude)));
                                },
                                child: Text(
                                  'See on Maps',
                                ),
                                color: Colors.blue[200],
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.red[100],
                ),
                height: MediaQuery.of(context).size.height * .25,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(8),
              ),
            );
          },
        ),

      ),
    );
  }
}

class Requests {
  String name;
  String address;
  double latitude;
  double longitude;
  String phone;
  String type;
  String uid;
  String st;

  Requests({
    this.address,
    this.latitude,
    this.longitude,
    this.name,
    this.phone,
    this.type,
    this.uid,
    this.st
  });
}
