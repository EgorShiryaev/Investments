import 'package:crypt/crypt.dart';

String hashingPassword(String password) {
  final hash = Crypt.sha256(password, salt: '1234567890').hash;
  return hash;
}
