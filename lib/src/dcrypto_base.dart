enum TextType {
  base64,
  pure,
}

abstract class CryptoDescriptor {
  String encrypt(String plaintext, String key);
  String decrypt(String chiphertext, String key);
}

class Crypto<T extends CryptoDescriptor> {
  T descriptor;

  Crypto(this.descriptor);

  String encrypt(String plaintext, String key) {
    return descriptor.encrypt(plaintext, key);
  }

  String decrypt(String plaintext, String key) {
    return descriptor.decrypt(plaintext, key);
  }
}
