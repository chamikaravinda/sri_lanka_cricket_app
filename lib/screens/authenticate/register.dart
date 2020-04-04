import 'package:app/services/auth.dart';
import 'package:app/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/shared/constants.dart';
class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading =false;


  //text filed state
  String name = '';
  String email = '';
  String password = '';
  String error ='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blue[900],
      body: Container(
        padding: EdgeInsets.fromLTRB(50.0, 100.0, 50.0, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                height: 120.0,
                image: AssetImage('images/sl_logo.png'),
              ),
              SizedBox(height: 20.0),
              Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight:FontWeight.w600,
                    letterSpacing: 2.0
                ),
              ),
              SizedBox(height: 12.0),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Name',
                          prefixIcon: Icon(Icons.person,color: Colors.grey,)
                      ),
                      validator: (val)=>val.isEmpty ? 'Enter the name' :null,
                      onChanged: (val){
                        setState(() => name=val);
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'E-mail',
                          prefixIcon: Icon(Icons.email,color: Colors.grey,)
                      ),
                      validator: (val)=>val.isEmpty ? 'Enter an email' :null,
                      onChanged: (val){
                        setState(() => email=val);
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.vpn_key,color: Colors.grey,)
                      ),
                      validator: (val)=>val.length<6 ? 'Enter a password longer than 6 characters' :null,
                      obscureText: true,
                      onChanged: (val){
                        setState(() => password=val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already have an account ?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        FlatButton(
                          onPressed: (){
                            widget.toggleView();
                          },
                          child:  Text(
                            'Sign In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                            setState(() =>loading=true);
                            dynamic result = _authService.registerWithEmailAndPassword(email, password,name);
                            if(result == null){
                              setState(() {
                                error ='Please supply a valid email';
                                loading = false;
                              });
                            }
                          }
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        padding: const EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                              colors: [
                                Color.fromRGBO(31,61,135,1),
                                Color.fromRGBO(223,186,47,1)
                              ],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Container(
                            constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
                            alignment: Alignment.center,
                            child: const Text(
                              'Sign Up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red,fontSize: 14.0),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
