import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'register-service.dart';
import 'thank-you.dart';
import 'package:location/location.dart';

class QuestionWidget extends StatefulWidget {
  final Map<String, dynamic> feedback;
  final int questionIndex;
  final LocationData location;

  QuestionWidget(this.feedback, this.questionIndex, this.location);

  _QuestionState createState() {
    return _QuestionState(this.feedback);
  }
}

class _QuestionState extends State<QuestionWidget> {
  Map<String, dynamic> feedback;
  Map<String, dynamic> question;

  bool loading = false;
  double value = 50;

  @override
  void initState() {
    super.initState();
    this.question = this.feedback['questions'][this.widget.questionIndex];
  }

  _QuestionState(feedback) {
    this.feedback = feedback;
  }

  prev() {
    print("Opening prev question");

    if (this.widget.questionIndex != 1) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => QuestionWidget(this.feedback,
                  this.widget.questionIndex - 1, this.widget.location)));
    }
  }

  save() async {
    setState(() {
      loading = true;
    });

    RegisterService service = RegisterService();
    Map<String, dynamic> data = new Map();

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    data['user_id'] = user.uid.toString();
    data['question_id'] = this.question['id'].toString();
    data['location'] = {
      'lat': this.widget.location.latitude.toString(),
      'lng': this.widget.location.longitude.toString()
    };
    var answers = new List<Map<String, dynamic>>();

    var answerA = new Map<String, dynamic>();
    answerA['id'] = this.question['answer_a']['id'];
    answerA['emotion'] = this.question['answer_a']['emotion'];
    answerA['value'] = (this.value / 100).toStringAsFixed(2);

    var answerB = new Map<String, dynamic>();
    answerB['id'] = this.question['answer_b']['id'];
    answerB['emotion'] = this.question['answer_b']['emotion'];
    answerB['value'] = ((100 - this.value) / 100).toStringAsFixed(2);

    answers.add(answerA);
    answers.add(answerB);
    data['answers'] = answers;

    Map res = await service.submitResponse(
        this.feedback['id'].toString(), jsonEncode(data));

    print("Opening new question");

    if (this.feedback['questions'].length == this.widget.questionIndex + 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ThankYouWidget()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => QuestionWidget(this.feedback,
                  this.widget.questionIndex + 1, this.widget.location)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
                margin: EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      question['title'],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28.0),
                    ),
                    answerImages(),
                    answerText(),
                    Slider(
                      min: 0,
                      max: 100,
                      value: value,
                      onChanged: (d) {
                        setState(() {
                          this.value = d;
                        });
                      },
                    ),
                    buttons()
                  ],
                ))));
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          child: Row(
              children: <Widget>[Icon(Icons.arrow_back), Text(' Previous')]),
          onPressed: () {
            prev();
          },
        ),
        FlatButton(
          child: Row(
            children: <Widget>[Text('Next '), Icon(Icons.arrow_forward)],
          ),
          onPressed: () {
            save();
          },
        )
      ],
    );
  }

  Widget answerText() {
    return Row(children: [
      Expanded(
          child: Text(
        question['answer_a']['text'],
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18.0),
      )),
      Expanded(
          child: Text(
        question['answer_b']['text'],
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18.0),
      )),
    ]);
  }

  Widget answerImages() {
    String aEmotion =
        this.question['answer_a']['emotion'].toString().toLowerCase();
    String bEmotion =
        this.question['answer_b']['emotion'].toString().toLowerCase();

    Widget a;
    Widget b;

    try {
      a = Image.asset('assets/memes/$aEmotion.jpg');
    } catch (e) {
      a = Image.network('https://placehold.it/400x400');
      print('Emotion image $aEmotion not found');
      print(e);
    }
    try {
      b = Image.asset('assets/memes/$bEmotion.jpg');
    } catch (e) {
      b = Image.network('https://placehold.it/400x400');
      print('Emotion image $bEmotion not found');
      print(e);
    }

    return Row(children: [
      Expanded(child: a),
      Expanded(child: b),
    ]);
  }
}
