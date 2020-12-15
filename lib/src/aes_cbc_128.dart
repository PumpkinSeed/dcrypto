import 'dart:convert';

import 'package:dcrypto/dcrypto.dart';
import 'package:encrypt/encrypt.dart';

class AES_CBC_128 implements CryptoDescriptor {
  TextType plaintextType = TextType.base64;
  TextType chipertextType = TextType.base64;
  TextType keyType = TextType.base64;
  String InitializationVector;

  AES_CBC_128(this.InitializationVector);

  @override
  String decrypt(String chiphertext, String key_) {
    Key key;
    switch (keyType) {
      case TextType.base64:
        key = Key.fromBase64(key_);
        break;
      case TextType.pure:
        key = Key.fromUtf8(key_);
        break;
    }
    final iv = IV.fromUtf8(InitializationVector);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: null));

    switch (chipertextType) {
      case TextType.base64:
        return encrypter.decrypt(Encrypted.fromBase64(chiphertext), iv: iv);
      case TextType.pure:
      // TODO: implement
    }
  }

  @override
  String encrypt(String plaintext, String key) {
    throw UnimplementedError();
  }
}
