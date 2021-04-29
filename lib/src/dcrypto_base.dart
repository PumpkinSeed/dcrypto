import 'dart:convert';

enum TextType {
  base64,
  pure,
}

abstract class CryptoDescriptor {
  String encrypt(List<int> plaintext, List<int> key);

  List<int> decrypt(List<int> ciphertext, List<int> key);
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

  String decrypt(String ciphertext_, String key_) {
    var key = _decode(keyType, key_);
    var ciphertext = _decode(plaintextType, ciphertext_);
    var dec = descriptor.decrypt(ciphertext, key);
    return _encode(plaintextType, dec);
  }

  String _encode(TextType type, List<int> data) {
    switch (type) {
      case TextType.base64:
        return base64.encode(data);
      case TextType.pure:
        return String.fromCharCodes(data);
      default:
        throw CryptoException('Invalid type submitted for encode: $type');
    }
  }

  List<int> _decode(TextType type, String data) {
    switch (type) {
      case TextType.base64:
        return base64.decode(data);
      case TextType.pure:
        return data.runes.toList();
      default:
        throw CryptoException('Invalid type submitted for decode: $type');
    }
  }
}

class CryptoException implements Exception {
  String cause;

  CryptoException(this.cause);
}
