import 'package:app/models/user.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/database.dart';
import 'package:app/shared/loading.dart';
import 'package:app/shared/sideDrawer.dart';
import 'package:flutter/material.dart';
import 'package:app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class Settings extends StatefulWidget {

  final Function toggleView;
  Settings({this.toggleView});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final AuthService _authService = AuthService();

  final _ediPofileFormKey = GlobalKey<FormState>();

  //text filed state
  String name;
  String password;
  String birthday;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //birthday picker

    Future<void> _selectDate(BuildContext context) async {
      final DateTime d = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year+1),

      );
      if (d != null)
        setState(() {
          birthday = new DateFormat.yMMMMd("en_US").format(d);
        });
    }

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;

          if(userData.birthDay != '' && birthday==null){
            birthday=userData.birthDay;
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Settings'),
              backgroundColor:  Colors.blue[900],
              elevation: 0.0,
            ),
            drawer: SideDrawer(toggleView: widget.toggleView),
            body: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Form(
                          key: _ediPofileFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 10.0,),
                              Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600
                                  )),
                              SizedBox(height: 30.0,),
                              Text(
                                  'Full Name',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal
                                  )),
                              SizedBox(height: 10.0,),
                              TextFormField(
                                decoration: textInputDecorationBlack.copyWith(
                                    hintText: 'Name',
                                    prefixIcon: Icon(Icons.person,color: Colors.grey,)
                                ),
                                initialValue: userData.name,
                                validator: (val)=>val.isEmpty ? 'Enter the name' :null,
                                onChanged: (val){
                                  setState(() => name=val);
                                },
                              ),
                              SizedBox(height: 20.0,),
                              Text(
                                  'Birth Date',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal
                                  )),
                              SizedBox(height: 10.0,),
                              Container(
                                height: 60.0,
                                decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(width: 1.0, color: Colors.grey),
                                      left: BorderSide(width: 1.0, color: Colors.grey),
                                      right: BorderSide(width: 1.0, color: Colors.grey),
                                      bottom: BorderSide(width: 1.0, color: Colors.grey),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    FlatButton.icon(
                                      icon: Icon(
                                        Icons.calendar_today,
                                        color: Colors.grey,
                                      ),
                                      label: Text(birthday ?? 'Tap to select birth date'),
                                      onPressed: () {
                                        _selectDate(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.0,),
                              Text(
                                  'Password',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal
                                  )),
                              SizedBox(height: 10.0,),
                              TextFormField(
                                decoration: textInputDecorationBlack.copyWith(
                                    hintText: 'Current Password',
                                    prefixIcon: Icon(Icons.vpn_key,color: Colors.grey,)
                                ),
                                obscureText: true,
                                validator: (val)=>val.length<6 ? 'Enter the valid password' :null,
                                onChanged: (val){
                                  setState(() => password=val);
                                },
                              ),
                              SizedBox(height: 42.0,),
                              Center(
                                child: FlatButton(
                                  color: Colors.blue[900],
                                  padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 15.0),
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                  onPressed: () async {
                                    if(_ediPofileFormKey.currentState.validate()){
                                      dynamic result = await _authService.updateUserDetaisl(
                                          userData.email
                                          ,password,
                                          name??userData.name,
                                          birthday??userData.birthDay
                                      );
                                      showToast(result.toString());
                                    }
                                  },
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }else{
          return Loading();
        }
      }
    );
  }
}
