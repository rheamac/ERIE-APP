import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyRegister extends StatefulWidget {
  final FirebaseUser userDetails;
  MyRegister( this.userDetails);

  Register createState(){
    print(this.userDetails);
    return Register(this.userDetails);

  }
}

class Register extends State {
  // This widget is the root of your application.
  //final _formKey = 
  FirebaseUser userDetails;
   Register(userDetails){this.userDetails = userDetails;}
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
        //  key: _formKey,
            child: ListView(
          children: <Widget>[
            TextField(
                decoration: InputDecoration(
                    hintText: 'Enter First Name', labelText: 'First Name')),
            TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Last Name', labelText: 'Last Name')),
            TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Email Address', labelText: 'Email')),
            TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Organization Name',
                    labelText: 'Organization')),
            TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Contact No.', labelText: 'Number')),
            TextFormField(
              validator :(value)
              {if(value.isEmpty)
              return 'Please enter Code';

              },
                decoration: InputDecoration(
                    hintText: 'Enter Postal Code', labelText: 'Postal Code')),
                    RaisedButton(child: Text('Register'),
                    onPressed: null)
          ],
        )),
      ),
    ));
  }
}
