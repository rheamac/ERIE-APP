import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import './register-model.dart';
import './register-service.dart';
import './feed.dart';

class MyRegister extends StatefulWidget {
  Map userDetails;

  MyRegister(this.userDetails);

  Register createState() {
    return Register(this.userDetails);
  }
}

class Register extends State {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  RegisterModel _data = new RegisterModel();
  RegisterService _registerService = new RegisterService();
  Map userDetails1;
  String fname;
  String lname;
  String id;
  Map mappedData;

  @override
  void initState() {
    super.initState();
  }

  Register(userDetails) {
    userDetails1 = userDetails;
    List arr = userDetails['displayName'].split(" ");
    fname = arr[0];
    lname = arr[1];
    id = userDetails['uid'];
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('ERIE - Register'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                    enabled: false,
                    initialValue: fname,
                    decoration: InputDecoration(
                        hintText: 'Enter First Name', labelText: 'First Name'),
                    onSaved: (String value) {
                      _data.first_name = value;
                    }),
                TextFormField(
                    enabled: false,
                    initialValue: lname,
                    decoration: InputDecoration(
                        hintText: 'Enter Last Name', labelText: 'Last Name'),
                    onSaved: (String value) {
                      _data.last_name = value;
                    }),
                TextFormField(
                    enabled: false,
                    keyboardType: TextInputType.emailAddress,
                    initialValue: userDetails1['email'],
                    decoration: InputDecoration(
                        hintText: 'Enter Email Address', labelText: 'Email'),
                    onSaved: (String value) {
                      _data.email = value;
                    }),
                TextFormField(
                    key: new Key('organization'),
                    // The validator receives the text the user has typed in
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter organization name';
                      }
                    },
                    maxLength: 32,
                    decoration: InputDecoration(
                        hintText: 'Enter Organization Name',
                        labelText: 'Organization'),
                    onSaved: (String value) {
                      _data.organization = value;
                    }),
                TextFormField(
                   key: new Key('student_id'),
                    validator: (value) {
                      if (value.isEmpty) return 'Please enter Student Id';
                    },
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    maxLength: 10,
                    decoration: InputDecoration(
                        hintText: 'Enter Student id', labelText: 'Student Id'),
                    onSaved: (String value) {
                      _data.student_id = value;
                    }),
                TextFormField(
                  key: new Key('phone_no'),
                    validator: (value) {
                      if (value.isEmpty) return 'Please enter Contact number';
                      if (!(value.length == 10))
                        return 'Please enter 10 digit Contact number';
                    },
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    maxLength: 10,
                    decoration: InputDecoration(
                        hintText: 'Enter Contact No.',
                        labelText: 'Contact Number'),
                    onSaved: (String value) {
                      _data.contact_no = value;
                    }),
                TextFormField(
                   key: new Key('postal_code'),
                    validator: (value) {
                      if (value.isEmpty) return 'Please enter  Postal code';
                      if (!(value.length == 6))
                        return 'Please enter Six digit Postal code';
                    },
                    maxLength: 6,
                    onSaved: (String value) {
                      _data.postal_code = value;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter Postal Code',
                        labelText: 'Postal Code')),
                RaisedButton(
                    child: Text('Register'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print("onsubmit data");
                        this._formKey.currentState.save();
                        _data.id = id;
                        this.mappedData = _data.toMap();
                        _registerService.postData(this.mappedData);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyFeedbackList()));
                      }
                    })
              ],
            )),
      ),
    ));
  }
}
