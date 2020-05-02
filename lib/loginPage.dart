

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidinit/main.dart';
import 'package:flutter/material.dart';
import 'gmaps.dart';
import 'MyRequest.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHome());
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String name;
  var phone;
  var address;
  var lat;
  var long;
  var uid;
  String dropdownValue = "Infectious";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Make a Request'),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (text) {
                    name = text;
                  },
                  decoration: InputDecoration(
                    hintText: 'Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (text) {
                    phone = text;
                  },
                  decoration: InputDecoration(hintText: 'Mobile No.'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (text) {
                    address = text;
                  },
                  decoration: InputDecoration(
                    suffixIcon: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => GMaps()));
                        },
                        child: Icon(Icons.map)),
                    hintText: 'Address',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Type of Waste: "),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>[
                        'Infectious','Radio Active','Sharps','Other'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 220),
              Container(
                height: 50,
                width: 270,
                child: RaisedButton(

                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  color: Colors.redAccent[200],
                  onPressed: () {
                    Firestore.instance
                        .collection('requests')
                        .document()
                        .setData({
                      'Name': name,
                      'Phone': phone,
                      'Address': address,
                      'Latitude': latitude,
                      'Longitude': longitude,
                      'Type': dropdownValue,
                      'Uid': x,
                      'Status': 'pending'
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyRequest()));
                  },
                  child: Text(
                    'Make Request!',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
