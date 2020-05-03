import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatelessWidget {
  TextEditingController t1 = new TextEditingController();
  TextEditingController t2 = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        'REGISTER',
                        style: GoogleFonts.aclonica(fontSize: 30,color: Colors.white),
                      ),
                    ),
                    height: 200,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 150),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * .7,
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        controller: t1,
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      TextFormField(
                        controller: t2,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 170,
                        child: RaisedButton(
                          color: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          ),
                          onPressed: () {
                            Fluttertoast.showToast(msg: 'User Registered');
                            register();
                          },
                          child: Text('Register'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  register() {
    _auth.createUserWithEmailAndPassword(email: t1.text, password: t2.text);
  }
}
