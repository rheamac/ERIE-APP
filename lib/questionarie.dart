import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './register-model.dart';
import './register-service.dart';
import './feed.dart';

class MyQuestionarie extends StatefulWidget {
  Map<String, dynamic> _newData;
  MyQuestionarie(data) {
    _newData = data;
  }
  Questionarie createState() {
    return Questionarie(_newData);
  }
}

class Questionarie extends State {
  Map<String, dynamic> _newData;
  @override
  void initState() {
    super.initState();
  }

  Questionarie(data) {
    _newData = data;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: ListView.builder(
                itemCount: _newData['questions'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_newData['questions'][index]['title']),
                    //   subtitle: Text(_newData['answer_a'][index]['title']),
                  );
                })));
  }
}
