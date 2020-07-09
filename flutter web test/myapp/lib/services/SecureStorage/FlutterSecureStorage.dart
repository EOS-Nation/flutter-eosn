import 'package:myapp/services/SecureStorage/SecureStorageInterface.dart';

class FlutterSecureStorage implements SecureStorageInterface {
  @override
  Future<void> delete({String key}) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll() {
    throw UnimplementedError();
  }

  @override
  Future<String> read({String key}) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, String>> readAll() {
    throw UnimplementedError();
  }

  @override
  Future<void> write({String key, String value}) {
    throw UnimplementedError();
  }
}
