import 'package:dcrypto/dcrypto.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  test('Base64 plaintext and pure key', () {
    var c = Crypto(AES_CBC_128('2271z4734hxepwb6'));
    c.keyType = TextType.pure;

    var key = 'xeq1m8i959r3bwgu';
    var plaintext = 'bTUxdWFxZGcyNjNhNW53Mw=='; // m51uaqdg263a5nw3
    var ciphertext = c.encrypt(plaintext, key);

    var decrypted = c.decrypt(ciphertext, key);
    var decodedText = utf8.decode(base64.decode(decrypted));
    expect(decodedText, 'm51uaqdg263a5nw3');
  });

  test('Pure plaintext and pure key', () {
    var c = Crypto(AES_CBC_128('2271z4734hxepwb6'));
    c.keyType = TextType.pure;
    c.plaintextType = TextType.pure;

    var key = 'xeq1m8i959r3bwgu';
    var plaintext = 'm51uaqdg263a5nw3';
    var ciphertext = c.encrypt(plaintext, key);

    var decrypted = c.decrypt(ciphertext, key);
    expect(decrypted, 'm51uaqdg263a5nw3');
  });

  test('Pure plaintext as input, base64 plaintext as output and pure key', () {
    var c = Crypto(AES_CBC_128('2271z4734hxepwb6'));
    c.keyType = TextType.pure;
    c.plaintextType = TextType.pure;

    var key = 'xeq1m8i959r3bwgu';
    var plaintext = 'm51uaqdg263a5nw3';
    var ciphertext = c.encrypt(plaintext, key);

    c.plaintextType = TextType.base64;
    var decrypted = c.decrypt(ciphertext, key);
    var decodedText = utf8.decode(base64.decode(decrypted));
    expect(decodedText, 'm51uaqdg263a5nw3');
  });

  test('Base64 plaintext as input, pure plaintext as output and pure key', () {
    var c = Crypto(AES_CBC_128('2271z4734hxepwb6'));
    c.keyType = TextType.pure;

    var key = 'xeq1m8i959r3bwgu';
    var plaintext = 'bTUxdWFxZGcyNjNhNW53Mw=='; // m51uaqdg263a5nw3
    var ciphertext = c.encrypt(plaintext, key);

    c.plaintextType = TextType.pure;
    var decrypted = c.decrypt(ciphertext, key);
    expect(decrypted, 'm51uaqdg263a5nw3');
  });

  test('Base64 plaintext and base64 key', () {
    var c = Crypto(AES_CBC_128('2271z4734hxepwb6'));

    var key = 'eGVxMW04aTk1OXIzYndndQ=='; // xeq1m8i959r3bwgu
    var plaintext = 'bTUxdWFxZGcyNjNhNW53Mw=='; // m51uaqdg263a5nw3
    var ciphertext = c.encrypt(plaintext, key);

    var decrypted = c.decrypt(ciphertext, key);
    var decodedText = utf8.decode(base64.decode(decrypted));
    expect(decodedText, 'm51uaqdg263a5nw3');
  });
}
