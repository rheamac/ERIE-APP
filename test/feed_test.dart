import 'package:erie/feed.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/erie-register.dart';

void main() {
  Map userDetails = {
    'displayName': 'Rhea Machado',
    'email': 'rheamac999@gmail.com',
    'uid': '123123'
  };
  // userDetails.

  //FeedbackList feedback = new FeedbackList();

  testWidgets('checks whether button pumps', (WidgetTester tester) async {
    await tester.pumpWidget(MyFeedbackList());
    Finder loginButton = find.byKey(new Key('newFeeds'));
    await tester.tap(loginButton);

    await tester.pump();
  });
}
