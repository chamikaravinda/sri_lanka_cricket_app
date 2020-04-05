import 'package:app/models/fixtures.dart';
import 'package:app/screens/home/setting_form.dart';
import 'package:app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/services/database.dart';
import 'package:app/screens/home/fixtures_list.dart';
import 'package:app/shared/sideDrawer.dart';

class Home extends StatelessWidget {

  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(
          context: context,
          builder: (context){
            return Container(
              padding: EdgeInsets.symmetric(vertical:20.0 , horizontal: 60.0),
              child: SettingsForm(),
            );
          }
      );
    }

    return StreamProvider<List<Fixtures>>.value(
      value: DatabaseService().fixtures,
      child: Scaffold(
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          title: Text('Sri Lanka Cricket'),
          backgroundColor:  Colors.blue[900],
          elevation: 0.0,
        ),
        drawer: SideDrawer(),
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
  }
}
