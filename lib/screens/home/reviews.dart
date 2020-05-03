import 'package:app/models/fixture.dart';
import 'package:app/screens/home/new_review.dart';
import 'package:app/services/database.dart';
import 'package:app/shared/sideDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_reviews.dart';

class Reviews extends StatefulWidget {
  final Function toggleView;
  Reviews({this.toggleView});

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> with SingleTickerProviderStateMixin {

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
//    StreamProvider<List<TicketBooking>>.value(
//    value: DatabaseService().userTicketBookings,
//    ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text('Reviews'),
            backgroundColor: Colors.blue[900],
            elevation: 0.0,
          ),
          drawer: SideDrawer(toggleView: widget.toggleView),
          body: Scaffold(
            appBar: AppBar(
              title: new TabBar(
                controller: _controller,
                tabs: [
                  Tab(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add),
                          Text(' New Review')
                        ],
                      )
                  ),
                  Tab(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.view_list),
                          Text(' My Reviews')
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
                        NewReview()
                      ],
                    ),
                  ),
                ),
                MyReviews(),
              ],
            ),
          ),
        )
    );
  }
}
