import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kopuro/export_files.dart';

void main() {
  testWidgets('Login form displays correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginForm()));

    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
  });
}
