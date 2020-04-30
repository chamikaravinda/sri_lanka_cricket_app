import 'package:app/models/fixture.dart';
import 'package:app/screens/home/tickets_booking_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicketNewBooking extends StatefulWidget {
  @override
  _TicketNewBookingState createState() => _TicketNewBookingState();
}

class _TicketNewBookingState extends State<TicketNewBooking> {


  @override
  Widget build(BuildContext context) {
    final fixtures = Provider.of<List<Fixture>>(context) ?? [];
    return TicketBookingForm(fixtures:fixtures);
  }
}
