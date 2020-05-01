import 'package:flutter/material.dart';
import 'package:covidinit/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'showRequest.dart';
import 'MyRequest.dart';
void main()=>runApp(Login());
String x;
class Login extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    )
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String dropdownValue = "User";
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
                  keyboardType: TextInputType.emailAddress,
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
                Row(
                  children: <Widget>[

                    Text('Login as:-'),
                    SizedBox(width: 100,),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                          color: Colors.deepPurple
                      ),
                      underline: Container(
                        height: 2,

                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['User', 'Municipalty']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                          .toList(),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: RaisedButton(
                        onPressed: () {
                          signIn();
                          if(dropdownValue=="User")
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyRequest()));
                          if(dropdownValue=="Municipalty")
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp1()));
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

  signIn() async{
    try{
      _auth.signInWithEmailAndPassword(email: t1.text, password: t2.text);
      FirebaseUser user = await _auth.currentUser();
      x = user.uid;

    }catch(e){
      print('Error');
    }}
}

