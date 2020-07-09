import 'package:myapp/services/SecureStorage/SecureStorageInterface.dart';

class FlutterSecureStorage implements SecureStorageInterface {
  static FlutterSecureStorage _storage;
  @override
  Future<void> delete({String key}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll() {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<String> read({String key}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Map<String, String>> readAll() {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<void> write({String key, String value}) {
    // TODO: implement write
    throw UnimplementedError();
  }
}
