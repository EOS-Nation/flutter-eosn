import 'package:encrypt/encrypt.dart';

class AESUtil {
  static final IV iv = IV.fromLength(16);

  static String encrypt(String msg, String key) {
    Key paddedkey = Key.fromUtf8(key.padLeft(32));
    Encrypter encrypter = Encrypter(AES(paddedkey));

    return encrypter.encrypt(msg, iv: iv).toString();
  }

  static String decrypt(msg, key) {
    Key paddedkey = Key.fromUtf8(key.padLeft(32));
    Encrypter encrypter = Encrypter(AES(paddedkey));
    try {
      return encrypter.decrypt(msg, iv: iv).toString();
    } catch (e) {
      print(e.toString());
      throw ('Could not decrypt password');
    }
  }
}
