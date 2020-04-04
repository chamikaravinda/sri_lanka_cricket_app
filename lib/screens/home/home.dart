import 'package:app/models/brew.dart';
import 'package:app/screens/home/setting_form.dart';
import 'package:app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/services/database.dart';
import 'package:app/screens/home/brew_list.dart';

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

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor:  Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async{
                  await _authService.signOut();
                },
                icon: Icon(Icons.person,color: Colors.white,),
                label: Text('Log out',style: TextStyle(color:Colors.white)),
            ),
            FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings),
                label: Text('Settings')
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              )
            ),
            child: BrewList()),
      ),
    );
  }
}
