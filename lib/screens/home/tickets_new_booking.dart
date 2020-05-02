import 'package:app/models/fixture.dart';
import 'package:app/screens/home/tickets_booking_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicketNewBooking extends StatefulWidget {

  TabController tabController;
  TicketNewBooking({this.tabController});

  @override
  _TicketNewBookingState createState() => _TicketNewBookingState(tabController);
}

class _TicketNewBookingState extends State<TicketNewBooking> {

  TabController tabController;
  _TicketNewBookingState(this.tabController);

  @override
  Widget build(BuildContext context) {
    final fixtures = Provider.of<List<Fixture>>(context) ?? [];
    return TicketBookingForm(fixtures:fixtures,tabController:tabController);
  }
}
