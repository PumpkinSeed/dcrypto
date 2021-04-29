import 'dart:typed_data';

import 'package:dcrypto/dcrypto.dart';
import 'package:encrypt/encrypt.dart';

class AES_CBC_128 implements CryptoDescriptor {
  String InitializationVector;

  AES_CBC_128(this.InitializationVector);

  @override
  String encrypt(List<int> plaintext, List<int> key) {
    final iv = IV.fromUtf8(InitializationVector);

    // Do the actual encrypt
    Encrypted enc;
    try {
      enc = Encrypter(AES(Key(Uint8List.fromList(key)), mode: AESMode.cbc, padding: null))
          .encryptBytes(plaintext, iv: iv);
    } catch (e) {
      rethrow;
    }

    return enc.base64;
  }

  @override
  List<int> decrypt(List<int> ciphertext, List<int> key) {
    final iv = IV.fromUtf8(InitializationVector);

    // Do the actual decrypt
    List<int> dec;
    try {
      dec = Encrypter(AES(Key(Uint8List.fromList(key)), mode: AESMode.cbc, padding: null))
          .decryptBytes(Encrypted(Uint8List.fromList(ciphertext)), iv: iv);
    } catch (e) {
      rethrow;
    }

    return dec;
  }
}
