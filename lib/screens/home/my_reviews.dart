import 'package:app/models/review.dart';
import 'package:app/screens/home/review_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyReviews extends StatefulWidget {
  @override
  _MyReviewsState createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {

  @override
  Widget build(BuildContext context) {

    final reviews = Provider.of<List<Review>>(context) ?? [];

    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context,index){
        return ReviewTile(review:reviews[index]);
      },
    );  }
}
