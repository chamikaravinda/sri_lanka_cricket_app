import 'dart:convert';
import 'package:app/models/fixture.dart';
import 'package:app/services/database.dart';
import 'package:app/shared/sideDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fixtures_calander.dart';


class Fixtures extends StatefulWidget {
  final Function toggleView;
  Fixtures({this.toggleView});

  @override
  _FixturesState createState() => _FixturesState();
}

class _FixturesState extends State<Fixtures> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Fixture>>.value(
      value: DatabaseService().fixtures,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fixtures Calander'),
          backgroundColor:  Colors.blue[900],
          elevation: 0.0,
        ),
        drawer: SideDrawer(toggleView: widget.toggleView),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FixtureCalander()
//              ..._selectedEvents.map((event) => ListTile(
//                title: Text(event),
//              )),
            ],
          ),
        ),
      ),
    );
  }

//  _showAddDialog() async {
//    await showDialog(
//        context: context,
//        builder: (context) => AlertDialog(
//          content: TextField(
//            controller: _eventController,
//          ),
//          actions: <Widget>[
//            FlatButton(
//              child: Text("Save"),
//              onPressed: () {
//                if (_eventController.text.isEmpty) return;
//                if (_events[_controller.selectedDay] != null) {
//                  _events[_controller.selectedDay]
//                      .add(_eventController.text);
//                } else {
//                  _events[_controller.selectedDay] = [
//                    _eventController.text
//                  ];
//                }
//                prefs.setString("events", json.encode(encodeMap(_events)));
//                _eventController.clear();
//                Navigator.pop(context);
//              },
//            )
//          ],
//        ));
//    setState(() {
//      _selectedEvents = _events[_controller.selectedDay];
//    });
//  }
}
