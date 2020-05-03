import 'package:covidinit/loginPage.dart';
import 'package:covidinit/munLogin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class showOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 100),
                Text(
                  'LOGIN',
                  style: GoogleFonts.aclonica(fontSize: 40),
                ),
                SizedBox(height: 270),
                Container(
                  height: 50,
                  width: 260,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MunLogin()));
                    },
                    color: Colors.redAccent,
                    child: Text(
                      'MUNICIPALITY',
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 50,
                  width: 260,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                    color: Colors.redAccent,
                    child: Text(
                      'USER',
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
