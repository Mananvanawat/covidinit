import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Register extends StatelessWidget{
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
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .7,
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: t1,
                  decoration: InputDecoration(
                    labelText: 'email',
                  ),
                ),
                TextFormField(
                  controller: t2,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: RaisedButton(
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
    );
  }

  register() {
    _auth.createUserWithEmailAndPassword(email: t1.text, password: t2.text);

  }
}
