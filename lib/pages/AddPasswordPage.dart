import 'package:cipherly/database/Database.dart';
import 'package:cipherly/model/PasswordModel.dart';
import 'package:cipherly/pages/PasswordHomepage.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:shared_preferences/shared_preferences.dart';

class AddPassword extends StatefulWidget {
  AddPassword({Key key}) : super(key: key);

  _AddPasswordState createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController appNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  encrypt.Encrypted encrypted;
  String keyString = "";
  String encryptedString = "";
  String decryptedString = "";
  String masterPassString = "";

  Future<Null> getMasterPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String masterPass = prefs.getString('master') ?? "";
    masterPassString = masterPass;
  }
  
  @override
  void initState() {
    getMasterPass();

    super.initState();
  }

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
                decoration: InputDecoration(
                    hintText: "User Name/Email (if available)",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
                controller: userNameController,
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
           
           
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          encryptPass(passwordController.text);
          Password password = new Password(
              appName: appNameController.text,
              password: encryptedString,
              userName: userNameController.text);
          DBProvider.db.newPassword(password);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => PasswordHomepage()),
              (Route<dynamic> route) => false);
        },
      ),
    );
  }

  encryptPass(String text) {
    keyString = masterPassString;
    if (keyString.length < 32) {
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
