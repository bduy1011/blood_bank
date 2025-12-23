import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

class AlgorisUtils {
  static const keyOrigin = "xxxxxxxxxxxxxxxxxxxxxxxxxx";
  // Encrypts the given plainText using the provided key
  static String encrypt(
    String plainText, {
    String? keyEncrypt,
  }) {
    String key = keyEncrypt ?? keyOrigin;
    final aesKey = _prepareKey(key); // Prepare AES key (128-bit)
    final iv = _prepareIV(key); // Prepare AES IV (128-bit)

    final encrypter = Encrypter(AES(Key(aesKey), mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: IV(iv));

    return encrypted.base64; // Return Base64 encoded string
  }

  // Decrypts the given Base64-encoded ciphertext using the provided key
  static String decrypt(
    String encryptedText, {
    String? keyEncrypt,
  }) {
    String key = keyEncrypt ?? keyOrigin;
    final aesKey = _prepareKey(key); // Prepare AES key (128-bit)
    final iv = _prepareIV(key); // Prepare AES IV (128-bit)

    final encrypter = Encrypter(AES(Key(aesKey), mode: AESMode.cbc));
    final decrypted = encrypter.decrypt64(encryptedText, iv: IV(iv));

    return decrypted; // Return decrypted plaintext
  }

  // Derive a 128-bit AES key from the input key string
  static Uint8List _prepareKey(String key) {
    final bytes = utf8.encode(key);
    return Uint8List.fromList(_adjustLength(bytes, 16)); // Ensure 128-bit key
  }

  // Derive a 128-bit AES IV from the input key string
  static Uint8List _prepareIV(String key) {
    final bytes = utf8.encode(key);
    return Uint8List.fromList(_adjustLength(bytes, 16)); // Ensure 128-bit IV
  }

  // Adjust the input bytes to the desired length (e.g., 16 bytes for AES)
  static List<int> _adjustLength(List<int> input, int length) {
    if (input.length == length) return input;
    if (input.length > length) return input.sublist(0, length);
    return List<int>.from(input)
      ..addAll(List<int>.filled(length - input.length, 0));
  }
}
