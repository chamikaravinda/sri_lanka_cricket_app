import 'package:app/models/review.dart';
import 'package:flutter/material.dart';

class ReviewTile extends StatelessWidget {

  final Review review;
  ReviewTile({this.review});

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
                    Text(review.game,
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
                ' Ratings : ${review.rating}',
                style: TextStyle(fontSize: 16.0,color: Colors.grey[800]),
              ),
              onTap: (){
                Navigator.pushNamed(context, '/user_review',arguments:review);
              },
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
