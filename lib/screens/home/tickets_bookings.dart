import 'package:app/models/ticket_booking.dart';
import 'package:app/screens/home/tickets_booking_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicketBookings extends StatefulWidget {
  @override
  _TicketBookingsState createState() => _TicketBookingsState();
}

class _TicketBookingsState extends State<TicketBookings> {
  
 @override
  Widget build(BuildContext context) {
   final bookings = Provider.of<List<TicketBooking>>(context) ?? [];

    return ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context,index){
          return TicketBookingTile(booking:bookings[index]);
        },
    );
  }
}
