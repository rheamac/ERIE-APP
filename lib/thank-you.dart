import 'package:flutter/material.dart';

class ThankYouWidget extends StatefulWidget {
  _ThankYouWidgetState createState() {
    return _ThankYouWidgetState();
  }
}

class _ThankYouWidgetState extends State {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
                margin: EdgeInsets.all(64.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Text('Thank You')]))));
  }
}
