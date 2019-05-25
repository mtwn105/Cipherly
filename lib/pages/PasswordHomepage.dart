import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class PasswordHomepage extends StatefulWidget {
  @override
  _PasswordHomepageState createState() => _PasswordHomepageState();
}

class _PasswordHomepageState extends State<PasswordHomepage> {
  TextEditingController passwordController = TextEditingController();


  encrypt.Encrypted encrypted;
  String encryptedString = "";
  String decryptedString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("cipherly"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
                controller: passwordController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Encrypted: $encryptedString"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Decrypted: $decryptedString"),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              encryptPass(passwordController.text);
            },
          ),
          SizedBox(
            width: 5,
          ),
          FloatingActionButton( onPressed: () {
              decryptPass();
            },
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  encryptPass(String text) {
    final plainText = text;
    final key = encrypt.Key.fromUtf8('my 32 length key................');
    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final e = encrypter.encrypt(plainText, iv: iv);

    encrypted = e;

    setState(() {
      encryptedString = e.base64.toString();
    });
  }

  decryptPass() {

    final key = encrypt.Key.fromUtf8('my 32 length key................');
    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    setState(() {
      decryptedString = decrypted.toString();
    });
  }
}
