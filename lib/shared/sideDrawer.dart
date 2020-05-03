import 'package:app/models/user.dart';
import 'package:app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/services/database.dart';
import 'loading.dart';

class SideDrawer extends StatefulWidget {

  final Function toggleView;
  SideDrawer({this.toggleView});

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid:user.uid).userData,
        builder: (context,snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Theme(
              data: Theme.of(context).copyWith(
              canvasColor: Colors.blue[900],
            ),
            child: Drawer(
              child:Column(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(userData.name ?? ''),
                    accountEmail: Text(userData.email ?? ''),
                    currentAccountPicture: CircleAvatar(
                      child: Text(
                        '${userData.name.toUpperCase()[0]}',
                        style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white
                        ),
                      ),
                      backgroundColor: Colors.blue[900],
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              'images/menu_header.png',
                            )
                        ),
                        color: Colors.blue[900]
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Home',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          onTap: () {
                            print('Change to Home');
                            widget.toggleView(1);
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.content_paste,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Fixtures',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          onTap: () {
                            print('Change to Fixtures');
                            widget.toggleView(2);
                          },
                        ),ListTile(
                          leading: Icon(
                            Icons.content_paste,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Tickets',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          onTap: () {
                            print('Change to Tickets');
                            widget.toggleView(3);
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.dvr,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Reviews',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          onTap: () {
                            print('Change to Reviews');
                            widget.toggleView(4);
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.view_list,
                            color: Colors.white,
                          ),
                          title: Text(
                            'ICC Test Championship',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.view_list,
                            color: Colors.white,
                          ),
                          title: Text(
                            'ICC ODI Championship',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.supervisor_account,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Squads',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.plus_one,
                            color: Colors.white,
                          ),
                          title: Text(
                            '1st Class Tournament',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                      child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Container(
                              child: Column(
                                children: <Widget>[
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                    ListTile(
                                      leading: Icon(
                                          Icons.settings,
                                          color: Colors.white,
                                      ),
                                      title: Text(
                                          'Settings',
                                        style: TextStyle(
                                          color: Colors.white
                                        ),
                                      ),
                                      onTap: (){
                                        widget.toggleView(8);
                                      },
                                    ),
                                  ListTile(
                                      leading: Icon(
                                          Icons.exit_to_app,
                                          color: Colors.white,
                                      ),
                                      title: Text(
                                          'Log Out',
                                          style: TextStyle(color: Colors.white),
                                      ),
                                      onTap:() async{
                                        await _authService.signOut();
                                      },
                                  )
                                ],
                              )
                          )
                      )
                  )
                ],
              ),
            ),
          );
          }else{
            return Loading();
          }
        }
    );
  }
}
