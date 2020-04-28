import 'package:app/models/user.dart';
import 'package:app/screens/wrapper.dart';
import 'package:app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: new ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue[900],
          backgroundColor: Colors.white,
          buttonColor: Colors.blue[900]

        ),
        home:Wrapper(),
      ),
    );
  }
}

