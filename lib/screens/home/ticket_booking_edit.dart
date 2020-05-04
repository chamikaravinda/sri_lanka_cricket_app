import 'package:app/models/ticket_booking.dart';
import 'package:app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:app/shared/constants.dart';

class TicketBookingEdit extends StatefulWidget {
  @override
  _TicketBookingEditState createState() => _TicketBookingEditState();
}

class _TicketBookingEditState extends State<TicketBookingEdit> {

  final _ticketFormKey = GlobalKey<FormState>();

  List<String> _dropDownCardType=["Visa","Master Card" ,"American Express"];
  String _noOfTickets = '';
  String _cardType;
  String _cardNumber;
  String _cvsNumber;


  @override
  Widget build(BuildContext context) {

    final TicketBooking booking = ModalRoute.of(context).settings.arguments;
    if(_cardType == null){
      _cardType=booking.cardType;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          child: Form(
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
                  )
                ),
                TextFormField(
                    decoration: textInputDecorationBlack.copyWith(
                        hintText: 'Game',
                        prefixIcon: Icon(Icons.event,color: Colors.grey,),
                        fillColor: Colors.grey[300]
                    ),
                    initialValue: booking.game,
                    readOnly: true,
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
                        prefixIcon: Icon(Icons.vpn_key,color: Colors.grey,),
                    ),
                    initialValue: booking.noOfTickets,
                    validator: (value) {
                      if(int.parse(value)<int.parse(booking.noOfTickets)){
                        return 'You can not decrease the number of tickets ';
                      }
                      if (int.parse(value)>10) {
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
                    initialValue: booking.cardNumber,
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
                      '        Update      ',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () async {
                      if(_ticketFormKey.currentState.validate()){
                        try{
                          dynamic result= await DatabaseService(uid:booking.uid).updateTicketBooking(
                              booking.bookingId,
                              booking.game,
                              _noOfTickets??booking.noOfTickets,
                              _cardType??booking.cardType,
                              _cardNumber??booking.cardNumber,
                              _cvsNumber
                          );
                          showToast('Booking Update Successfull');
                          Navigator.pop(context);
                        }catch(e){
                          showToast('Error: $e');
                        }
                      }
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
                Center(
                  child: FlatButton(
                    color: Colors.red[900],
                    padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 15.0),
                    child: Text(
                        'Cancel Booking',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () async {
                      try{
                        bool confirm = await _confirmDialog();
                        if(confirm){
                          await DatabaseService(uid:booking.uid).cancelBooking(booking.bookingId);
                          showToast('Booking Canceled');
                          Navigator.pop(context);
                        }
                      }catch(e){
                        showToast('Error: $e');
                      }
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmDialog() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure ?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.pop(context,true);
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context,false);
              },
            )
          ],
        );
      },
    );
  }
}
