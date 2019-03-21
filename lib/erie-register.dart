import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './register-model.dart';
import './register-service.dart';
import './feed.dart';

class MyRegister extends StatefulWidget {
  final FirebaseUser userDetails;
  MyRegister(this.userDetails);

  Register createState() {
    //print(this.userDetails);
    return Register(this.userDetails);
  }
}

class Register extends State {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  RegisterModel _data = new RegisterModel();
  RegisterService _registerService = new RegisterService();
  FirebaseUser userDetails1;
  String fname;
  String lname;
  String id;
  Map mappedData;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: 'Initial value');
  }

  Register(userDetails) {
    userDetails1 = userDetails;
    List arr = userDetails1.displayName.split(" ");
    fname = arr[0];
    lname = arr[1];
    id = userDetails1.uid;
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
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                    initialValue: fname,
                    decoration: InputDecoration(
                        hintText: 'Enter First Name', labelText: 'First Name'),
                    onSaved: (String value) {
                      _data.first_name = value;
                    }),
                TextFormField(
                    initialValue: lname,
                    decoration: InputDecoration(
                        hintText: 'Enter Last Name', labelText: 'Last Name'),
                    onSaved: (String value) {
                      _data.last_name = value;
                    }),
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    initialValue: userDetails1.email,
                    decoration: InputDecoration(
                        hintText: 'Enter Email Address', labelText: 'Email'),
                    onSaved: (String value) {
                      _data.email = value;
                    }),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Enter Organization Name',
                        labelText: 'Organization'),
                    onSaved: (String value) {
                      _data.organization = value;
                    }),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Enter Student id', labelText: 'Student Id'),
                    onSaved: (String value) {
                      _data.student_id = value;
                    }),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Enter Contact No.', labelText: 'Number'),
                    onSaved: (String value) {
                      _data.contact_no = value;
                    }),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) return 'Please enter Code';
                    },
                    onSaved: (String value) {
                      _data.postal_code = value;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter Postal Code',
                        labelText: 'Postal Code')),
                RaisedButton(
                    child: Text('Register'),
                    onPressed: () {
                      print("onsubmit data");
                      this._formKey.currentState.save();
                      _data.id = id;
                      this.mappedData = _data.toMap();
                      _registerService.postData(this.mappedData);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyFeedbackList()));
                    })
              ],
            )),
      ),
    ));
  }
}
