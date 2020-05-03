import 'package:covidinit/loginPage.dart';
import 'package:flutter/material.dart';
import 'showOptions.dart';
void main() => runApp(Login());

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      home: showOptions(),
    ));
  }
}
