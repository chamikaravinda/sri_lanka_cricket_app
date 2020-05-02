import 'package:app/models/user.dart';
import 'package:app/screens/wrapper.dart';
import 'package:app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child:Wrapper()
    );
  }
}

