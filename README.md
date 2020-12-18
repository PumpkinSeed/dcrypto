# dcrypto - Dart crypto

Simple extendable crypto package written in Dart

### Structure

There is the `Crypto` wrapper responsible for data normalization. There are types of data how it is passed to the handler and it creates the right format. The `CryptoDescriptor` define the main functionalities of the extensions. 

### Usage (AES-CBC-128)

```
import 'package:dcrypto/dcrypto.dart';

// Create a new Crypto instance and passing the extension to it.
// AES_CBC_128 is the extension and requires an initialization vector.
var c = Crypto(AES_CBC_128('2271z4734hxepwb6'));

// The default values for key and plaintext types are base64
var key = 'eGVxMW04aTk1OXIzYndndQ=='; // xeq1m8i959r3bwgu
var plaintext = 'bTUxdWFxZGcyNjNhNW53Mw=='; // m51uaqdg263a5nw3

// Pass the plaintext and key to the encrypt endpoint
// Returns a base64 encoded ciphertext (can't be changed)
var ciphertext = c.encrypt(plaintext, key);

// ...

// Pass the ciphertext to the decrypt along with the key
// Returns the decrypted value as base64 encoded
var decrypted = c.decrypt(ciphertext, key);
```

#### Change input types

```
import 'package:dcrypto/dcrypto.dart';

var c = Crypto(AES_CBC_128('2271z4734hxepwb6'));
c.keyType = TextType.pure; // Change the key type to pure (simple string)
c.plaintextType = TextType.pure; // Change the plaintext type to pure (simple string)

var key = 'xeq1m8i959r3bwgu';
var plaintext = 'm51uaqdg263a5nw3';

// NOTE: Returns a base64 encoded ciphertext (can't be changed)
var ciphertext = c.encrypt(plaintext, key);

// ...

// Returns the decrypted value as base64 encoded because it's change back
c.plaintextType = TextType.base64;
var decrypted = c.decrypt(ciphertext, key);
```

### Writing extensions

Extensions must implement the `CryptoDescriptor` to be accepted. All of the inputs arrives as pure TextType except the ciphertext. Ciphertext always based on the implementation, but it's suggested to accept the same format for decryption as the encrypt returned it.