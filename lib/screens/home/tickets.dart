import 'package:app/screens/home/tickets_form.dart';
import 'package:app/services/database.dart';
import 'package:app/shared/sideDrawer.dart';
import 'package:flutter/material.dart';
import 'package:app/models/fixture.dart';
import 'package:provider/provider.dart';


class Tickets extends StatefulWidget {

  final Function toggleView;
  Tickets({this.toggleView});

  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Fixture>>.value(
      value: DatabaseService().latestFixtures,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tickets'),
          backgroundColor:  Colors.blue[900],
          elevation: 0.0,
        ),
        drawer: SideDrawer(toggleView: widget.toggleView),
        body: new DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title:new TabBar(
                tabs: [
                  Tab(
                    child:Row(
                        children: <Widget>[
                          Icon(Icons.add),
                          Text(' New Booking')
                        ],
                    )
                  ),
                  Tab(
                      child:Row(
                        children: <Widget>[
                          Icon(Icons.view_list),
                          Text(' My Bookings')
                        ],
                      )
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TicketForm(),
                      ],
                    ),
                  ),
                ),
                Icon(Icons.directions_transit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
