import 'package:myapp/services/SecureStorage/SecureStorageInterface.dart';

class WebSecureStorage implements SecureStorageInterface {
  static var _storage = <String, String>{};
  @override
  Future<void> delete({String key}) async {
    if (_storage.containsKey(key)) {
      _storage.remove(key);
    }
  }

  @override
  Future<void> deleteAll() async {
    _storage = <String, String>{};
  }

  @override
  Future<String> read({String key}) async {
    if (_storage.containsKey(key)) {
      return _storage[key];
    }
  }

  @override
  Future<Map<String, String>> readAll() async {
    return _storage;
  }

  @override
  Future<void> write({String key, String value}) async {
    _storage[key] = value;
  }
}
