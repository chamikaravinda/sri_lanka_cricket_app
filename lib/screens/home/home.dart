import 'package:app/models/fixture.dart';
import 'package:app/screens/home/fixtures.dart';
import 'package:app/screens/home/reviews.dart';
import 'package:app/screens/home/settings.dart';
import 'package:app/screens/home/tickets.dart';
import 'package:app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/services/database.dart';
import 'package:app/screens/home/fixtures_list.dart';
import 'package:app/shared/sideDrawer.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int showPage = 1;

  void toggleView(int page){
    setState(() => showPage = page);
  }

  @override
  Widget build(BuildContext context) {

    if(showPage==1){
      return StreamProvider<List<Fixture>>.value(
        value: DatabaseService().latestFixtures,
        child: Scaffold(
          backgroundColor: Colors.blue[200],
          appBar: AppBar(
            title: Text('Sri Lanka Cricket'),
            backgroundColor:  Colors.blue[900],
            elevation: 0.0,
          ),
          drawer: SideDrawer(toggleView: toggleView),
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/bg.jpg'),
                    fit: BoxFit.cover,
                  )
              ),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.stretch ,
                children: <Widget>[
                  SafeArea(
                    child: SizedBox(height: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Card(
                      child: ListTile(
                        title:Text(
                          'Upcoming Fixtures',
                          style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w600),
                        ),
                        onTap: (){},
                      ),
                    ),
                  ),
                  Expanded(child: FixturesList()),
                  //:TODO Add the sponser bottom bar and make the home screen scrollable
                ],
              )
          ),
        ),
      );
    }else if(showPage ==2 ) {
      return Fixtures(toggleView: toggleView,);
    }else if(showPage ==3 ) {
      return Tickets(toggleView: toggleView,);
    }else if(showPage ==4 ) {
      return Reviews(toggleView: toggleView,);
    }else if(showPage ==8) {
      return Settings(toggleView: toggleView,);
    }else{
      return Loading();
    }
  }
}
