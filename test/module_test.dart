import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Email validation returns false for invalid email', () {
    var result = validateEmail('invalid-email');
    expect(result, false);
  });
}

validateEmail(String s) {
}
