import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[900],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.yellow[600],
          size: 50.0,
        ),
      ),
    );
  }
}
