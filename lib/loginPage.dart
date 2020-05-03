import 'package:covidinit/MyRequest.dart';
import 'package:covidinit/register.dart';
import 'package:covidinit/showRequest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

String x;

class _LoginPageState extends State<LoginPage> {
  String dropdownValue = "User";
  TextEditingController t1 = new TextEditingController();
  TextEditingController t2 = new TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .7,
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: t1,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextFormField(
                  controller: t2,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: RaisedButton(
                        onPressed: () {
                          signIn();
                        },
                        child: Text('Login'),
                      ),
                    ),
                    Container(
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ));
                        },
                        child: Text('Register'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signIn() async {
    //   String message;

    try {
      await _auth.signInWithEmailAndPassword(email: t1.text, password: t2.text);
      FirebaseUser user = await _auth.currentUser();
      x = user.uid;
      showSnackbar('Logged in');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyRequest()));
    } catch (e) {
      if (e is PlatformException) {
        showSnackbar(e.message);
      }
    }
//
  }

  void showSnackbar(String message) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
