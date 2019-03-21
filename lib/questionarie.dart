import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './register-model.dart';
import './register-service.dart';
import './feed.dart';

class MyQuestionarie extends StatefulWidget {
  Map<String, dynamic> _newData;
  MyQuestionarie(data){
_newData = data;
  }
  Questionarie createState() {
    return Questionarie(_newData);
  }
}

class Questionarie extends State {
  @override
  void initState() {
    super.initState();
  }

  Questionarie(data) {
    print(data);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('ERIE'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
            child: ListView(
          children: <Widget>[
            Text('New Feeds'),
          ],
        )),
      ),
    ));
  }
}
