import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loginPage.dart';
import 'main.dart';

class MyRequest extends StatelessWidget {
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
        .where("Uid", isEqualTo: x.toString())
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Requests'),
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                })
          ],
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

  Requests({
    this.address,
    this.latitude,
    this.longitude,
    this.name,
    this.phone,
    this.type,
    this.uid,
  });
}
