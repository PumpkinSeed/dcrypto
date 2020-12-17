import 'dart:convert';

enum TextType {
  base64,
  pure,
}

abstract class CryptoDescriptor {
  String encrypt(String plaintext, String key);
  String decrypt(String ciphertext, String key);
}

class Crypto<T extends CryptoDescriptor> {
  TextType plaintextType = TextType.base64;
  TextType keyType = TextType.base64;
  T descriptor;

  Crypto(this.descriptor);

  String encrypt(String plaintext_, String key_) {
    var key = _decode(keyType, key_);
    var plaintext = _decode(plaintextType, plaintext_);
    return descriptor.encrypt(plaintext, key);
  }

  String decrypt(String ciphertext, String key_) {
    var key = _decode(keyType, key_);
    var dec = descriptor.decrypt(ciphertext, key);
    return _encode(plaintextType, dec);
  }

  String _encode(TextType type, String data) {
    try {
      switch (type) {
        case TextType.base64:
          return base64.encode(utf8.encode(data));
        case TextType.pure:
          return data;
        default:
          throw CryptoException('Invalid type submitted for encode: $type');
      }
    } catch (e) {
      rethrow;
    }
  }

  String _decode(TextType type, String data) {
    try {
      switch (type) {
        case TextType.base64:
          return utf8.decode(base64.decode(data));
        case TextType.pure:
          return data;
        default:
          throw CryptoException('Invalid type submitted for decode: $type');
      }
    } catch (e) {
      rethrow;
    }
  }
}

class CryptoException implements Exception {
  String cause;
  CryptoException(this.cause);
}
