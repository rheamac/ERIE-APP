import 'package:flutter/material.dart';

class RegisterModel {
  var first_name;
  var last_name;
  var email;
  var id;
  var organization;
  var student_id;
  var contact_no;
  var postal_code;

  Map toMap() {
    var mapValue = new Map();
    mapValue['first_name'] = this.first_name;
    mapValue['last_name'] = this.last_name;
    mapValue['email'] = this.email;
    mapValue['id'] = this.id;
    mapValue['organisation'] = this.organization;
    mapValue['student_id'] = this.student_id;
    mapValue['contact_no'] = this.contact_no;
    mapValue['postal_code'] = this.organization;
    return mapValue;
  }
}
