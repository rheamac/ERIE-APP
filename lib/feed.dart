import 'package:flutter/material.dart';
import 'package:location/location.dart';
import './register-service.dart';
import './question.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyFeedbackList extends StatefulWidget {
  FeedbackList createState() {
    return FeedbackList();
  }
}

class FeedbackList extends State {
  List<dynamic> _data;

  @override
  void initState() {
    super.initState();
  }

  FeedbackList() {
    feedbackListData();
  }

  feedbackListData() async {
    RegisterService _registerService = new RegisterService();
    List<dynamic> res = await _registerService.getData();
    print(_data);
    setState(() {
      _data = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('ERIE - Available Feedbacks'),
            ),
            body: list()));
  }

  Widget list() {
    if (_data == null) {
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
          itemCount: _data.length,
          itemBuilder: (context, index) {
            return this.item(_data[index]);
          });
    }
  }

  Widget item(Map<String, dynamic> item) {
    int questions = item['questions'].length;

    return ExpansionTile(
      title: Text(
        item['name'],
        textScaleFactor: 1.2,
      ),
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(16.0),
            child: Text(item['description'] ?? '')),
        Container(
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.centerLeft,
          child: Text(
            questions.toString() +
                ' questions (' +
                ((questions / 2)).toString() +
                ' minutes)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.centerRight,
            child: RaisedButton(
                child: Text('New Feedback'),
                onPressed: () async {
                  var locationD = new Location();
                  LocationData currentLocation;

                  try {
                    currentLocation = await locationD.getLocation();
                  } catch (e) {
                    // currentLocation.longitude = 0;
                  }

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              QuestionWidget(item, 0, currentLocation)));
                }))
      ],
    );
  }
}
