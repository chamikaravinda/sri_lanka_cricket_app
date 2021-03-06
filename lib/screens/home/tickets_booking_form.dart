import 'package:flutter/material.dart';
import 'package:app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/shared/constants.dart';

class TicketBookingForm extends StatefulWidget {

  final fixtures;
  final TabController tabController;
  TicketBookingForm({this.fixtures,this.tabController});

  @override
  _TicketBookingFormState createState() => _TicketBookingFormState(this.fixtures,this.tabController);
}

class _TicketBookingFormState extends State<TicketBookingForm> {

  final fixtures;
  final TabController tabController;
  _TicketBookingFormState(this.fixtures,this.tabController);

  final _ticketFormKey = GlobalKey<FormState>();

  List<String> _dropDownGame = [];
  List<String> _dropDownCardType=["Visa","Master Card" ,"American Express"];
  String _game;
  String _noOfTickets = '';
  String _cardType="Visa";
  String _cardNumber;
  String _cvsNumber;

  @override
  void initState() {
    String temp;
    fixtures.forEach((fixture) => {
      temp = fixture.match+"\n VS "+fixture.vs,
      _dropDownGame.add(temp),
    });
    _game = _dropDownGame.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _ticketFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 5.0),
          Text(
              'Game',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal
              )),
          SizedBox(height: 10.0,),
          FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: textInputDecorationBlack.copyWith(
                    hintText: 'Game',
                    prefixIcon: Icon(Icons.event,color: Colors.grey,)
                ),
                isEmpty: _game == '',
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _game,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        _game = newValue;
                        state.didChange(newValue);
                      });
                    },
                    items: _dropDownGame.map<DropdownMenuItem<String>>((String itemValue) {
                      return DropdownMenuItem<String>(
                        value: itemValue,
                        child: Text(itemValue),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20.0,),
          Text(
              'No of Tickets',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal
              )),
          SizedBox(height: 10.0,),
          TextFormField(
              decoration: textInputDecorationBlack.copyWith(
                  hintText: 'Not more than 10 tickets',
                  prefixIcon: Icon(Icons.art_track,color: Colors.grey,)
              ),
              initialValue: _noOfTickets,
              validator: (value) {
                if(value==null||value==''){
                  return 'Enter the valid ticket amount';
                }
                else if (value.isEmpty) {
                  return 'Enter the valid ticket amount';
                }else  if(int.parse(value)>10){
                  return 'You can not book more than 10 tickets';
                }
                return null;
              },
              onChanged: (val){
                setState(() => _noOfTickets=val);
              },
              keyboardType: TextInputType.numberWithOptions(decimal: true)
          ),
          SizedBox(height: 20.0,),
          Text(
              'Debit/Credit Card Type',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal
              )),
          SizedBox(height: 10.0,),
          FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: textInputDecorationBlack.copyWith(
                    hintText: 'Debit/Credit Card Type',
                    prefixIcon: Icon(Icons.credit_card,color: Colors.grey,)
                ),
                isEmpty: _cardType == '',
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _cardType,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        _cardType = newValue;
                        state.didChange(newValue);
                      });
                    },
                    items: _dropDownCardType.map<DropdownMenuItem<String>>((String itemValue) {
                      return DropdownMenuItem<String>(
                        value: itemValue,
                        child: Text(itemValue),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20.0,),
          Text(
              'Card Number',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal
              )),
          SizedBox(height: 10.0,),
          TextFormField(
              decoration: textInputDecorationBlack.copyWith(
                  hintText: 'Credit Card number',
                  prefixIcon: Icon(Icons.credit_card,color: Colors.grey,)
              ),
              validator: (val)=>val.length!=16 ? 'Enter the valid Card Number' :null,
              onChanged: (val){
                setState(() => _cardNumber=val);
              },
              keyboardType: TextInputType.numberWithOptions(decimal: true)
          ),
          SizedBox(height: 20.0,),
          Text(
              'CSV',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal
              )),
          SizedBox(height: 10.0,),
          TextFormField(
              decoration: textInputDecorationBlack.copyWith(
                  hintText: 'Credit Card csv number',
                  prefixIcon: Icon(Icons.vpn_key,color: Colors.grey,)
              ),
              validator: (val)=>val.length!=3 ? 'Enter the valid CSV Number' :null,
              onChanged: (val){
                setState(() =>_cvsNumber=val);
              },
              keyboardType: TextInputType.numberWithOptions(decimal: true)
          ),
          SizedBox(height: 42.0),
          Center(
            child: FlatButton(
              color: Colors.blue[900],
              padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 15.0),
              child: Text(
                'Confirm',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              onPressed: () async {
                if(_ticketFormKey.currentState.validate()){
                  try{
                    FirebaseUser user = await FirebaseAuth.instance.currentUser();
                    dynamic result= await DatabaseService(uid:user.uid).addTicketBooking(_game, _noOfTickets, _cardType, _cardNumber, _cvsNumber);
                    if(result!=null){
                      showToast('Booking Successfull');
                      widget.tabController.index = 1;
                    }else{
                      showToast('Error in booking the tickets');
                    }
                  }catch(e){
                    showToast('Error: $e');
                  }
                }
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          )
        ],
      ),
    );
  }
}
