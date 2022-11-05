import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureLocalDatasource {
  static const _emailKey = 'email';
  static const _passworkKey = 'password';

  final FlutterSecureStorage _secureStorage;

  const SecureLocalDatasource({
    required FlutterSecureStorage secureStorage,
  }) : _secureStorage = secureStorage;

  Future<String?> get email {
    return _secureStorage.read(key: _emailKey);
  }

  Future<String?> get password {
    return _secureStorage.read(key: _passworkKey);
  }

  Future<void> saveEmail(String email) async {
    await _secureStorage.write(key: _emailKey, value: email);
  }

  Future<void> savePassword(String newpassword) async {
    await _secureStorage.write(key: _passworkKey, value: newpassword);
  }

  Future<void> deleteSavedEmail() async {
    await _secureStorage.delete(key: _emailKey);
  }

  Future<void> deleteSavedPassword() async {
    await _secureStorage.delete(key: _passworkKey);
  }
}
