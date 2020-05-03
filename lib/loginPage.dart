import 'package:covidinit/MyRequest.dart';
import 'package:covidinit/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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


      body: SingleChildScrollView(
        child: Center(
          child: Container(

            width: MediaQuery.of(context).size.width * .7,
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 100),
                  Text('LOGIN',style: GoogleFonts.aclonica(fontSize: 40,color: Colors.redAccent),),
                  SizedBox(height: 200,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: t1,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: t2,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: RaisedButton(
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)
                          ),
                          onPressed: () {
                            signIn();
                          },
                          child: Text('Login',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        child: RaisedButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ));
                          },
                          child: Text('Register',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
