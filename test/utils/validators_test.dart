import 'package:covtrack/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    test('E-mail', () {
      expect(Validators.isValidEmail(''), false);
      expect(Validators.isValidEmail('johndoe@'), false);
      expect(Validators.isValidEmail('johndoe@mail.'), false);
      expect(Validators.isValidEmail('johndoe@mail.com-joe@mail.com'), false);
      expect(Validators.isValidEmail('johndoe@mail.it'), true);
    });

    test('Password', () {
      expect(Validators.isValidPassword(''), false);
      expect(Validators.isValidPassword('1234567890'), false);
      expect(Validators.isValidPassword('abcdefghijklmnopqrstuvwxyz'), false);
      expect(Validators.isValidPassword('ABCDEFGHIYKLMNOPQRSTUVWXYZ'), false);
      expect(Validators.isValidPassword('Ab1234'), false);
      expect(Validators.isValidPassword('Abcd12345'), true);
    });
  });
}
