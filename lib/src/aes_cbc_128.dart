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
    // Fetch key from the String
    Key key;
    try {
      key = _fetchKey(key_);
    } catch (e) {
      rethrow;
    }
    final iv = IV.fromUtf8(InitializationVector);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: null));

    // Do the actual decrypt after fetch the encrypted data from ciphertext
    String e;
    try {
      switch (chipertextType) {
        case TextType.base64:
          e = encrypter.decrypt(Encrypted.fromBase64(chiphertext), iv: iv);
          break;
        case TextType.pure:
          e = encrypter.decrypt(Encrypted.fromUtf8(chiphertext), iv: iv);
          break;
        default:
          throw CryptoException('Invalid chipertextType submitted');
      }
    } catch (e) {
      rethrow;
    }

    // Normalize result based on the plaintextType
    try {
      switch (plaintextType) {
        case TextType.base64:
          return base64.encode(utf8.encode(e));
        case TextType.pure:
          return e;
      }
    } catch (e) {
      rethrow;
    }

    throw CryptoException('Invalid plaintextType submitted');
  }

  @override
  String encrypt(String plaintext, String key_) {
    // Fetch key from the String
    Key key;
    try {
      key = _fetchKey(key_);
    } catch (e) {
      rethrow;
    }
    final iv = IV.fromUtf8(InitializationVector);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: null));

    // Do the actual encrypt after fetch the decrypted data from plaintext
    Encrypted enc;
    try {
      switch (plaintextType) {
        case TextType.base64:
          var decodedText = utf8.decode(base64.decode(plaintext));
          enc = encrypter.encrypt(decodedText, iv: iv);
          break;
        case TextType.pure:
          enc = encrypter.encrypt(plaintext, iv: iv);
          break;
        default:
          throw CryptoException('Invalid plaintextType submitted');
      }
    } catch (e) {
      rethrow;
    }

    // Normalize result based on the chipertextType
    try {
      switch (chipertextType) {
        case TextType.base64:
          return enc.base64;
        case TextType.pure:
          return enc.toString();
      }
    } catch (e) {
      rethrow;
    }

    throw CryptoException('Invalid chipertextType submitted');
  }

  Key _fetchKey(String key) {
    try {
      switch (keyType) {
        case TextType.base64:
          return Key.fromBase64(key);
        case TextType.pure:
          return Key.fromUtf8(key);
          break;
        default:
          throw CryptoException('Invalid keyType submitted');
      }
    } catch (e) {
      rethrow;
    }
  }
}
