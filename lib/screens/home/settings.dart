import 'package:app/models/user.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/database.dart';
import 'package:app/shared/loading.dart';
import 'package:app/shared/sideDrawer.dart';
import 'package:flutter/material.dart';
import 'package:app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Settings extends StatefulWidget {

  final Function toggleView;
  Settings({this.toggleView});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final AuthService _authService = AuthService();

  final _ediPofileFormKey = GlobalKey<FormState>();
  final _changePasswordFormKey = GlobalKey<FormState>();

  //text filed state
  String name = '';
  String email = '';
  String password = '';
  String birthday = null;

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
      print (d);
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
          name = userData.name;
          email =userData.email;

          if(userData.birthDay != '' && birthday == null){
            birthday = userData.birthDay;
          }


          return Scaffold(
            backgroundColor: Colors.blue[200],
            appBar: AppBar(
              title: Text('Settings'),
              backgroundColor:  Colors.blue[900],
              elevation: 0.0,
            ),
            drawer: SideDrawer(toggleView: widget.toggleView),
            body: Stack(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/bg.jpg'),
                          fit: BoxFit.fill,
                        )
                    )
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Card(
                            child: Padding(
                              padding:EdgeInsets.all(10.0) ,
                              child: Form(
                                key: _ediPofileFormKey,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 10.0),
                                    Text(
                                        'Edit Profile',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600
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
                                    Container(
                                      decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Colors.grey),
                                            left: BorderSide(width: 1.0, color: Colors.grey),
                                            right: BorderSide(width: 1.0, color: Colors.grey),
                                            bottom: BorderSide(width: 1.0, color: Colors.grey),
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(15))
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
                                    SizedBox(height: 12.0,),
                                    FlatButton(
                                      color: Colors.blue[900],
                                      child: Text(
                                        'Update',
                                        style: TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                      onPressed: () async {
                                        if(_ediPofileFormKey.currentState.validate()){
                                          dynamic result = await _authService.updateUserDetaisl(email,password,name,birthday);
                                          if(result!=null){
                                            showToast('Update Successfull');
                                          }else{
                                            showToast('Error in updating the userprofile');
                                          }
                                        }
                                      },
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                    )
                                  ],
                                ),
                              ),
                            ),
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
