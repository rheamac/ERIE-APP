import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  // This widget is the root of your application.
  //final _formKey = 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
        //  key: _formKey,
            child: ListView(
          children: <Widget>[]
          
        )),
      ),
    ));
  }
}
