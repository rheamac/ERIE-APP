import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './register-service.dart';
import './questionarie.dart';

class MyFeedbackList extends StatefulWidget {
  FeedbackList createState() {
    //print(this.userDetails);
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
    FeedbackListData();
  }

  FeedbackListData() async {
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
              title: Text('ERIE'),
            ),
            body: _data == null
                ? Text('Loading...')
                : ListView.builder(
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> item = _data[index];
                      return ExpansionTile(
                        title: Text(item['name']),
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerRight,
                              child: Text(item['questions'].length.toString() +
                                  ' questions')),
                          Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerRight,
                              child: RaisedButton(
                                  child: Text('New Feedback'),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyQuestionarie(item)));
                                  }))
                        ],
                      );
                    })));
  }
}
