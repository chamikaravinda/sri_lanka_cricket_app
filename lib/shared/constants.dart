import 'package:flutter/material.dart';

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


