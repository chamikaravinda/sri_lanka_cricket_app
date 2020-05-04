import 'package:app/models/review.dart';
import 'package:app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:app/services/database.dart';

class ReviewEdit extends StatefulWidget {
  @override
  _ReviewEditState createState() => _ReviewEditState();
}

class _ReviewEditState extends State<ReviewEdit> {

  final _ticketFormKey = GlobalKey<FormState>();

  String _review;
  double _rating;

  @override
  Widget build(BuildContext context) {

    final Review review = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue[900],),
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
                SizedBox(height: 10.0,),
                TextFormField(
                  decoration: textInputDecorationBlack.copyWith(
                    hintText: 'Game',
                    prefixIcon: null,
                    fillColor: Colors.grey[300]
                  ),
                  initialValue: review.game,
                  readOnly: true,
                ),
                SizedBox(height: 20.0,),
                Text(
                    'Rating',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal
                    )),
                SizedBox(height: 10.0,),
                RatingBar(
                  initialRating: review.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating=rating;
                    });
                  },
                ),
                SizedBox(height: 20.0,),
                Text(
                    'Review',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal
                    )),
                SizedBox(height: 10.0,),
                TextFormField(
                  decoration: textInputDecorationBlack.copyWith(
                    hintText: 'Enter your review',
                    prefixIcon: null,
                  ),
                  validator:(value){
                    if (value == null || value == '') {
                      return 'Enter a review';
                    }
                    return null;
                  },
                  initialValue: review.review,
                  onChanged: (val){
                    setState(() => _review=val);
                  },
                  keyboardType: TextInputType.multiline,
                  minLines: 10,
                  maxLines: 15,
                ),
                SizedBox(height: 42.0,),
                Center(
                  child: FlatButton(
                    color: Colors.blue[900],
                    padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 15.0),
                    child: Text(
                      ' Update ',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () async {
                      if(_ticketFormKey.currentState.validate()){
                        try{
                          dynamic result = await DatabaseService(uid:review.uid).updateReview(
                              review.reviewId,
                              review.game,
                              _rating??review.rating,
                              _review??review.review);
                          showToast('Review edit Successfull');
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
                      'Remove',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () async {
                      try{
                        bool confirm = await _confirmDialog();
                        if(confirm){
                          await DatabaseService(uid:review.uid).deleteReview(review.reviewId);
                          showToast('Review Removed');
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
