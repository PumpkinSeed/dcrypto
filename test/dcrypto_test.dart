import 'package:dcrypto/dcrypto.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    var c = Crypto(AES_CBC_128(''));
  });
}
