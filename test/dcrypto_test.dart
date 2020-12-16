import 'package:dcrypto/dcrypto.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  group('A group of tests', () {
    var a = AES_CBC_128('2271z4734hxepwb6');
    a.keyType = TextType.pure;
    var c = Crypto(a);

    var key = 'xeq1m8i959r3bwgu';
    var plaintextBase64 = 'bTUxdWFxZGcyNjNhNW53Mw=='; // m51uaqdg263a5nw3
    var ciphertext = c.encrypt(plaintextBase64, key);

    var decrypted = c.decrypt(ciphertext, key);
    print('text: $decrypted');
    var decodedText = utf8.decode(base64.decode(decrypted));
    print('text: $decodedText');

    if (decodedText != 'm51uaqdg263a5nw3') {
      print('ERROR');
    }
  });
}
