import 'package:dcrypto/dcrypto.dart';
import 'package:encrypt/encrypt.dart';

class AES_CBC_128 implements CryptoDescriptor {
  String InitializationVector;

  AES_CBC_128(this.InitializationVector);

  @override
  String decrypt(String chiphertext, String key) {
    final iv = IV.fromUtf8(InitializationVector);

    // Do the actual decrypt
    String dec;
    try {
      dec = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.cbc, padding: null))
          .decrypt(Encrypted.fromUtf8(chiphertext), iv: iv);
    } catch (e) {
      rethrow;
    }

    return dec;
  }

  @override
  String encrypt(String plaintext, String key) {
    final iv = IV.fromUtf8(InitializationVector);

    // Do the actual encrypt
    Encrypted enc;
    try {
      enc = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.cbc, padding: null))
          .encrypt(plaintext, iv: iv);
    } catch (e) {
      rethrow;
    }

    return enc.toString();
  }
}
