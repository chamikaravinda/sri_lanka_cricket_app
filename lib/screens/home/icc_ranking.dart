import 'package:app/shared/sideDrawer.dart';
import 'package:flutter/material.dart';

class ICCRanking extends StatefulWidget {
  final Function toggleView;
  ICCRanking({this.toggleView});

  @override
  _ICCRankingState createState() => _ICCRankingState();
}

class _ICCRankingState extends State<ICCRanking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ICC Ranking'),
        backgroundColor:  Colors.blue[900],
        elevation: 0.0,
      ),
      drawer: SideDrawer(toggleView: widget.toggleView),
    );
  }
}
