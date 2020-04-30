import 'package:app/models/ticket_booking.dart';
import 'package:flutter/material.dart';

class TicketBookingTile extends StatelessWidget {

  final TicketBooking booking;
  TicketBookingTile({this.booking});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Card(
            elevation: 0.0,
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.fromLTRB(3.0, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(booking.game,
                      style: TextStyle(
                          fontSize: 16.0
                      ),
                    ),
                    SizedBox(height: 4.0),
                    SizedBox(height: 5.0),
                  ],
                ),
              ),
              subtitle: Text(
                  ' ${booking.noOfTickets} Tickets',
                style: TextStyle(fontSize: 16.0,color: Colors.grey[800]),
              ),
              onTap: (){},
            ),
          ),
        ),
        Padding(
            padding:EdgeInsets.symmetric(horizontal:15.0) ,
            child: Divider(color: Colors.black,)
        )
      ],
    );
  }
}
