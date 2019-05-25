import 'package:cipherly/database/Database.dart';
import 'package:cipherly/model/PasswordModel.dart';
import 'package:cipherly/pages/PasswordHomepage.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class AddPassword extends StatefulWidget {
  AddPassword({Key key}) : super(key: key);

  _AddPasswordState createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController appNameController = TextEditingController();
  TextEditingController masterPassController = TextEditingController();

  encrypt.Encrypted encrypted;
  String keyString = "";
  String encryptedString = "";
  String decryptedString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Password"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "App Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
                controller: appNameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
                controller: passwordController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
              
                maxLength: 32,
                decoration: InputDecoration(
                    hintText: "Master Pass",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
                controller: masterPassController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Encrypted: $encryptedString"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          encryptPass(passwordController.text);
          Password password = new Password(
              appName: appNameController.text,
              password: encryptedString);
          DBProvider.db.newPassword(password);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => PasswordHomepage()));
        },
      ),
    );
  }

  encryptPass(String text) {
    keyString = masterPassController.text;
    if(keyString.length<32){
      int count = 32 - keyString.length;
      for (var i = 0; i < count; i++) {
        keyString += ".";
      }
    }
  final key = encrypt.Key.fromUtf8(keyString);
    final plainText = text;
    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final e = encrypter.encrypt(plainText, iv: iv);
    encryptedString = e.base64.toString();
  }

 
}
