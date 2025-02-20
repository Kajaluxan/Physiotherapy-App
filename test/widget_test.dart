import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/sign_in_page.dart';


void main() {
  testWidgets('Email validation test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignInPage1()));

    // Find the email field and enter an invalid email
    await tester.enterText(find.byType(TextFormField).first, 'invalidemail');
    await tester.tap(find.byType(ElevatedButton)); // Tap Sign-in button
    await tester.pump();

    // Expect error message
    expect(find.text('Please enter a valid email'), findsOneWidget);
  });
}
