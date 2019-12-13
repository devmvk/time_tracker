import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/authentication/email_sign_in_form.dart';
import 'package:time_tracker/services/auth.dart';

class MockAuth extends Mock implements AuthBase {}

void main() {

  MockAuth mockAuth;

  setUp(() {
    mockAuth = MockAuth();
  });

  Future<void> pumpEmailSignInForm(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthBase>(
        builder: (_) => mockAuth,
        child: MaterialApp(
          home: Scaffold(body: EmailSignInForm()),
        ),
      ),
    );
  }
}