import 'package:app/screens/home/review_edit.dart';
import 'package:app/screens/home/ticket_booking_edit.dart';
import 'package:flutter/material.dart';

import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue[900],
        backgroundColor: Colors.amber,
        buttonColor: Colors.blue[900],
        canvasColor:Colors.white,
      ),
      initialRoute:'/' ,
      routes: {
        '/': (context) => Home(),
        '/user_booking':(context) => TicketBookingEdit(),
        '/user_review':(context) => ReviewEdit()
      },
    );
  }
}

