import 'package:app/screens/authenticate/register.dart';
import 'package:app/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authernticate extends StatefulWidget {
  @override
  _AuthernticateState createState() => _AuthernticateState();
}

class _AuthernticateState extends State<Authernticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return Container(
        child: SignIn(toggleView:toggleView),
      );
    }else{
      return Container(
        child: Register(toggleView:toggleView),
      );
    }

  }
}
