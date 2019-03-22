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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.asset('assets/memes/thanks.jpg'),
                      Text(
                        'We will get back with a report soon !',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 28.0),
                      ),
                      RaisedButton(
                        child: Text('Okay'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ]))));
  }
}
