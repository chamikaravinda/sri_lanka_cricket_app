import 'package:app/screens/authenticate/authenticate.dart';
import 'package:app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/models/user.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //return either home of authenticate widget
    if(user == null){
      return Authernticate();
    }else{
      return Home();
    }
  }
}
