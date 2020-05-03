import 'package:app/models/fixture.dart';
import 'package:app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'new_review_form.dart';

class NewReview extends StatefulWidget {
  TabController tabController;
  NewReview({this.tabController});

  @override
  _NewReviewState createState() => _NewReviewState(tabController);
}

class _NewReviewState extends State<NewReview> {

  TabController tabController;
  _NewReviewState(this.tabController);

  @override
  Widget build(BuildContext context) {
    final fixtures = Provider.of<List<Fixture>>(context) ?? [];
    if(fixtures.length==0){
      return Loading();
    }else{
      return NewReviewForm(fixtures:fixtures,tabController:tabController);
    }
  }
}
