import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


const textInputDecoration =  InputDecoration(
    hintText: 'E-mail',
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(color: Colors.white,width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: Colors.white,width: 2.0)
    ),
    errorBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: Colors.white,width: 2.0)
    ),
    focusedErrorBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: Colors.white,width: 2.0)
    ),
  );

const textInputDecorationBlack =  InputDecoration(
    hintText: 'E-mail',
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(color: Colors.grey,width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: Colors.grey,width: 1.0)
    ),
    errorBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: Colors.red,width: 2.0)
    ),
    focusedErrorBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: Colors.red,width: 2.0)
    ),
  );


void showToast(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue[900],
      textColor: Colors.white,
      fontSize: 16.0
  );
}