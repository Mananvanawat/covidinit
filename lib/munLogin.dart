
import 'package:covidinit/showRequest.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class MunLogin extends StatefulWidget {
  @override
  _MunLoginState createState() => _MunLoginState();
}

class _MunLoginState extends State<MunLogin> { TextEditingController t1 = new TextEditingController();
TextEditingController t2 = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .7,
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 100),
                    Text('MUNICIPALITY',style: GoogleFonts.aclonica(fontSize: 35,color: Colors.cyan),),
                    Text('LOGIN',style: GoogleFonts.aclonica(fontSize: 35,color: Colors.cyan),),
                    SizedBox(height: 200,),
                    TextFormField(
                      controller: t1,
                      decoration: InputDecoration(
                        labelText: 'Username',
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
                              if(t1.text=='mun1'&& t2.text=='123')
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp1()));
                              else
                                SnackBar(
                                  content: Text('Wrong Credentials'),
                                );
                            },
                            child: Text('Login',style: TextStyle(color: Colors.white),),
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
      ),
    );
  }
}
