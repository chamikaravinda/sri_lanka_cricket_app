import 'package:app/models/ticket_booking.dart';
import 'package:app/screens/home/tickets_bookings.dart';
import 'package:app/screens/home/tickets_new_booking.dart';
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

class _TicketsState extends State<Tickets> with SingleTickerProviderStateMixin{

  TabController _controller;

  @override
  void initState() {
    _controller = new TabController(
      length: 2,
      vsync: this
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Fixture>>.value(
          value: DatabaseService().latestFixtures,
        ),
        StreamProvider<List<TicketBooking>>.value(
          value: DatabaseService().userTicketBookings,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tickets'),
          backgroundColor:  Colors.blue[900],
          elevation: 0.0,
        ),
        drawer: SideDrawer(toggleView: widget.toggleView),
        body: Scaffold(
          appBar: AppBar(
            title:new TabBar(
              controller: _controller,
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
            controller: _controller,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TicketNewBooking(tabController: _controller,),
                    ],
                  ),
                ),
              ),
              TicketBookings(),
            ],
          ),
        ),
      ),
    );
  }
}
