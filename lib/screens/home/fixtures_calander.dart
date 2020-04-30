import 'dart:core';
import 'package:app/models/fixture.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class FixtureCalander extends StatefulWidget {
  @override
  _FixtureCalanderState createState() => _FixtureCalanderState();
}

class _FixtureCalanderState extends State<FixtureCalander> {

  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;


  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _selectedEvents = [];
  }



  @override
  Widget build(BuildContext context) {

    final fixturesData = Provider.of<List<Fixture>>(context) ?? [];

    Map<DateTime, List<dynamic>> _fixtures={};

    DateTime tempdate;
    List<dynamic> tempEventList=[];

    fixturesData.forEach((fixture) => {
      tempdate = DateTime.parse('${fixture.date} ${fixture.time}:00.000'),
      tempEventList.add(fixture.match+" \nVS "+fixture.vs),
      _fixtures.putIfAbsent(tempdate, () =>tempEventList ),
      tempEventList=[]
    });

    return Column(
      children: <Widget>[
        TableCalendar(
          events: _fixtures,
          initialCalendarFormat: CalendarFormat.month,
          calendarStyle: CalendarStyle(
              canEventMarkersOverflow: true,
              todayColor: Colors.orange,
              selectedColor: Theme.of(context).primaryColor,
              todayStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white)),
          headerStyle: HeaderStyle(
            centerHeaderTitle: true,
            formatButtonDecoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20.0),
            ),
            formatButtonTextStyle: TextStyle(color: Colors.white),
            formatButtonShowsNext: false,
          ),
          startingDayOfWeek: StartingDayOfWeek.monday,
          onDaySelected: (date, events) {
            setState(() {
              _selectedEvents = events;
            });
          },
          builders: CalendarBuilders(
            selectedDayBuilder: (context, date, events) => Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white),
                )),
            todayDayBuilder: (context, date, events) => Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white),
                )),
          ),
          calendarController: _controller,
        ),
        ..._selectedEvents.map((event) => ListTile(
          title: Text(
              event,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize:20.0
            ),
          ),
        )),
      ],
    );
  }
}
