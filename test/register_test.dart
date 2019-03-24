import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:erie/main.dart';
import '../lib/erie-register.dart';

void main() {
  Map userDetails = {
    'displayName': 'Rhea Machado',
    'email': 'rheamac999@gmail.com',
    'uid': '123123'
  };
  // userDetails.

  Register reg = new Register(userDetails);
  group('MyRegister', () {
    test('Check last name match with the input provided', () {
      expect(reg.lname, 'Machado');
    });

    test('Check first name match with the input provided ', () {
      expect(reg.fname, 'Rhea');
    });

    test('Check Email match with the input provided ', () {
      expect(reg.userDetails1['email'], 'rheamac999@gmail.com');
    });

    testWidgets('Find Organization text box exists',
        (WidgetTester tester) async {
      // Build the Widget
      await tester.pumpWidget(MyRegister(userDetails));
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Organization'), 'Organization');
    });
    testWidgets('Find Phone Number text box exists',
        (WidgetTester tester) async {
      // Build the Widget
      await tester.pumpWidget(MyRegister(userDetails));
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Contact Number'), '1212121212');
    });
    testWidgets('Find Postal code text box exists',
        (WidgetTester tester) async {
      // Build the Widget
      await tester.pumpWidget(MyRegister(userDetails));
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Postal Code'), '123456');
    });
    testWidgets('Find Student id text box exists', (WidgetTester tester) async {
      // Build the Widget
      await tester.pumpWidget(MyRegister(userDetails));
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Student Id'), '12345656');
    });
    // check that the organiztion text box is empty
    testWidgets('Find Organization is empty at the start', (WidgetTester tester) async {
      Finder organizationText = find.byKey(new Key('organization'));
      expect(organizationText.toString().contains(''), true);
    });
    testWidgets('Find postal code is empty at the start', (WidgetTester tester) async {
      Finder postalcodevalue = find.byKey(new Key('postal_code'));
      expect(postalcodevalue.toString().contains(''), true);
    });
    testWidgets('Find Contact number is empty at the start', (WidgetTester tester) async {
      Finder postalcodevalue = find.byKey(new Key('phone_no'));
      expect(postalcodevalue.toString().contains(''), true);
    });
     testWidgets('Find Contact number is empty at the start', (WidgetTester tester) async {
      Finder postalcodevalue = find.byKey(new Key('phone_no'));
      expect(postalcodevalue.toString().contains(''), true);
    });
     testWidgets('Find Student id is empty at the start', (WidgetTester tester) async {
      Finder postalcodevalue = find.byKey(new Key('student_id'));
      expect(postalcodevalue.toString().contains(''), true);
    });
  });
}
