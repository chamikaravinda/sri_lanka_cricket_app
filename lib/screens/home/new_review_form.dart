import 'package:app/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:app/services/database.dart';

class NewReviewForm extends StatefulWidget {

  final fixtures;
  final TabController tabController;
  NewReviewForm({this.fixtures,this.tabController});

  @override
  _NewReviewFormState createState() => _NewReviewFormState(this.fixtures,this.tabController);
}

class _NewReviewFormState extends State<NewReviewForm> {

  final fixtures;
  final TabController tabController;
  _NewReviewFormState(this.fixtures,this.tabController);

  final _ticketFormKey = GlobalKey<FormState>();

  List<String> _dropDownGame = [];
  String _game;
  String _review = '';
  double _rating=1;

  @override
  void initState() {
    print("Inside the form");
    print(fixtures.toString());
      String temp;
      fixtures.forEach((fixture) => {
        temp = fixture.match+"\n VS "+fixture.vs,
        _dropDownGame.add(temp),
      });
      _game = _dropDownGame.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
              )),
          SizedBox(height: 10.0,),
          FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: textInputDecorationBlack.copyWith(
                    hintText: 'Game',
                    prefixIcon: Icon(Icons.event,color: Colors.grey,)
                ),
                isEmpty: _game == '',
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _game,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        _game = newValue;
                        state.didChange(newValue);
                      });
                    },
                    items: _dropDownGame.map<DropdownMenuItem<String>>((String itemValue) {
                      return DropdownMenuItem<String>(
                        value: itemValue,
                        child: Text(itemValue),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
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
            initialRating: _rating,
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
                'Add',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              onPressed: () async {
                if(_ticketFormKey.currentState.validate()){
                  try{
                    FirebaseUser user = await FirebaseAuth.instance.currentUser();
                      dynamic result= await DatabaseService(uid:user.uid).addReview(_game, _rating, _review);
                      if(result!=null){
                        showToast('Rating adding Successfull');
                        widget.tabController.index = 1;
                      }else{
                        showToast('Error in adding the review');
                      }
                  }catch(e){
                    showToast('Error: $e');
                  }
                }
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          )
        ],
      ),
    );
  }
}
