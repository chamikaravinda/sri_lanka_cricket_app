import 'package:flutter/material.dart';
import 'package:app/models/fixtures.dart';

class FixturesTile extends StatelessWidget {
  final Fixtures fixtures;
  FixturesTile({this.fixtures});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage(
                'images/${fixtures.flag}.png'),
          ),
          title: Padding(
            padding: EdgeInsets.fromLTRB(3.0, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(''
                    'vs ${fixtures.vs}',
                  style: TextStyle(
                      fontSize: 22.0
                  ),
                ),
                SizedBox(height: 4.0),
                Row(
                  children: <Widget>[
                    Text(''
                        'Date : ${fixtures.date}',
                      style: TextStyle(
                          fontSize: 14.0
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(''
                        'Time : ${fixtures.time}',
                      style: TextStyle(
                          fontSize: 14.0
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
              ],
            ),
          ),
          subtitle: Text(' ${fixtures.match}'),
          onTap: (){},
        ),
      ),
    );
  }
}
