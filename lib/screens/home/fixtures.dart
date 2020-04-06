import 'package:app/shared/sideDrawer.dart';
import 'package:flutter/material.dart';

class FixturesCalander extends StatefulWidget {

  final Function toggleView;
  FixturesCalander({this.toggleView});

  @override
  _FixturesCalanderState createState() => _FixturesCalanderState();
}

class _FixturesCalanderState extends State<FixturesCalander> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text('Sri Lanka Cricket'),
        backgroundColor:  Colors.blue[900],
        elevation: 0.0,
      ),
      drawer: SideDrawer(toggleView: widget.toggleView),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg.jpg'),
              fit: BoxFit.cover,
            )
        ),
      ),
    );
  }
}
