// import 'dart:io';
// import 'package:encrypt/encrypt.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:pem/pem.dart';
// import 'package:rsa_encrypt/rsa_encrypt.dart';
// import 'package:pointycastle/asymmetric/pkcs1.dart';
// import 'package:pointycastle/api.dart';
// import 'package:pointycastle/asymmetric/api.dart';
// import 'package:pointycastle/asymmetric/rsa.dart';
// import 'package:pointycastle/key_generators/api.dart';
// import 'package:pointycastle/key_generators/rsa_key_generator.dart';
// import 'package:pointycastle/key_derivators/api.dart';
// import 'package:pointycastle/key_derivators/pbkdf2.dart';
// import 'package:pointycastle/digests/sha256.dart';

// Supongamos que privateKeyString y publicKeyString son tus claves en formato de cadena.
//  getKey() async {
//   var url = 'https://joseviveresm.000webhostapp.com/login?api';
//   final response = await http.get(Uri.parse(url));
//
//   if (response.statusCode == 200) {
//     var keys = jsonDecode(response.body);
//     String publicKey = keys['publicKey'];
//     print(publicKey);
//   } else {
//     throw Exception('Failed to load keys');
//   }
// }
// Crear el codificador/decodificador PKCS1
// final rsaPKCS1 = new RSAKeyParser();
//
// // Parsear la clave privada y pública
// RSAPrivateKey privateKey = rsaPKCS1.parse(privateKeyString) as RSAPrivateKey;
// RSAPublicKey publicKey = rsaPKCS1.parse(publicKeyString) as RSAPublicKey;
//
// void encrypted(data,publicKey) {
//   String encrypted = RsaKeyHelper().encrypt(data, publicKey);
// }
//
// void decrypted(List<String> args) {
//   final privKey = RSAKeyParser().parse(File('private.pem').readAsStringSync());
//   final encrypted = Encrypted.fromBase64(args[0]);
//   final encrypter = Encrypter(RSA(privateKey: privKey));
//   final decrypted = encrypter.decrypt(encrypted);
//   print(decrypted);
// }
// import 'dart:convert';
// import 'dart:io';
// import 'package:pointycastle/asymmetric/api.dart';
// import 'package:pointycastle/asymmetric/rsa.dart';
// import 'package:pointycastle/export.dart';
//
// void main() {

//
//   final publicKeyPEM = contents.split('-----END PRIVATE KEY-----')[0] + '-----END PUBLIC KEY-----';
//   final publicKeyDER = base64.decode(publicKeyPEM.split('\n').where((line) => line.isNotEmpty).join());
//
//   final keyFactory = KeyFactory.getInstance("RSA");
//   final publicKey = keyFactory.createKeyFromBytes(publicKeyDER, KeyType.public);
//
//   print('Public Key: $publicKey');
// }
import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'dart:convert';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/export.dart';
import 'package:basic_utils/basic_utils.dart';

Future<String> getKey(String plaintext) async {
  String pemContent = await rootBundle.loadString('assets/publica.pem');
  print(pemContent);
  // print(pemContent);
  // Crear el codificador/decodificador PKCS1
final rsaPKCS1 = new RSAKeyParser();

// Parsear la clave privada y pública
RSAPublicKey publicKey = rsaPKCS1.parse(pemContent) as RSAPublicKey;
print(publicKey);

  var cipher = PKCS1Encoding(RSAEngine());
  print(cipher);
  cipher.init(true, PublicKeyParameter<RSAPublicKey>(publicKey));

  Uint8List output = cipher.process(Uint8List.fromList(utf8.encode(plaintext)));
  print(output);
  String base64EncodedText = base64Encode(output);
  print(base64EncodedText);
  return base64EncodedText;
  // print(base64EncodedText);
}


// import 'package:flutter/services.dart' show rootBundle;
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:basic_utils/basic_utils.dart';
// import 'package:pointycastle/export.dart';
// import 'package:rsa_encrypt/rsa_encrypt.dart';
//
// class Cryptom {
//   String publickey = "YourPublicKeyHere";
//
//
//   Future<String> getKey(plaintext) async {
//     String pemContent = await rootBundle.loadString('assets/publica.pem');
//     var public = CryptoUtils.rsaPublicKeyFromPem(pemContent);
//     var cipher = PKCS1Encoding(RSAEngine());
//     cipher.init(true, PublicKeyParameter<RSAPublicKey>(public));
//     Uint8List output = cipher.process(Uint8List.fromList(utf8.encode(plaintext)));
//     var base64EncodedText = base64Encode(output);
//     return base64EncodedText;
//   }
//
//   String text(String text) {
//     return encrypt(text, publickey);
//   }
//
//   void getKey() {
//     String? result = Cryptom().text("TEXT TO BE ENCRYPTED");
//     print(result);
//   }
// }



// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:basic_utils/basic_utils.dart';
// import 'package:pointycastle/export.dart';
//
// class Cryptom {
//   String publickey = "YourPublicKeyHere";
//
//   String encrypt(String plaintext, String publicKey) {
//     var pem = '-----BEGIN RSA PUBLIC KEY-----\n$publickey\n-----END RSA PUBLIC KEY-----';
//     var public = CryptoUtils.rsaPublicKeyFromPem(pem);
//     var cipher = PKCS1Encoding(RSAEngine());
//     cipher.init(true, PublicKeyParameter<RSAPublicKey>(public));
//     Uint8List output = cipher.process(Uint8List.fromList(utf8.encode(plaintext)));
//     var base64EncodedText = base64Encode(output);
//     return base64EncodedText;
//   }
//
//   String text(String text) {
//     return encrypt(text, publickey);
//   }
//
//   void main() {
//     String? result = Cryptom().text("TEXT TO BE ENCRYPTED");
//     print(result);
//   }
// }


// import 'package:encrypt/encrypt_io.dart';
// import 'package:pem/pem.dart';
// getKey() async {
// final publicKey = await parseKeyFromFile<RSAPublicKey>('assets/publica.pem');
// final encrypter = Encrypter(RSA(publicKey: publicKey));
// final encrypted = encrypter.encrypt('Hello World');
// print("heloooo");
// print(encrypted.base64);
// }