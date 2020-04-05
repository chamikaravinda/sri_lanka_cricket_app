import 'package:app/models/fixtures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/screens/home/fixtures_tile.dart';

class FixturesList extends StatefulWidget {
  @override
  _FixturesListState createState() => _FixturesListState();
}

class _FixturesListState extends State<FixturesList> {
  @override
  Widget build(BuildContext context) {
    final fixtures = Provider.of<List<Fixtures>>(context) ?? [];

    return ListView.builder(
        itemCount: fixtures.length,
        itemBuilder: (context,index){
          return FixturesTile(fixtures:fixtures[index]);
        },
    );
  }
}
