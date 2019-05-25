import 'package:cipherly/model/PasswordModel.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class ViewPassword extends StatefulWidget {
  final Password password;

  const ViewPassword({Key key, this.password}) : super(key: key);

  @override
  _ViewPasswordState createState() => _ViewPasswordState(password);
}

class _ViewPasswordState extends State<ViewPassword> {
  final Password password;
  _ViewPasswordState(this.password);

  TextEditingController masterPassController = TextEditingController();

  String decrypted = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(password.appName),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("User Name: ${password.userName}"),
            Text("Password: ${password.password}"),
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
            MaterialButton(
              color: Colors.blue,
              child: Text("DECRYPT"),
              onPressed: () {
                decryptPass(password.password);
              },
            ),
            Text("Decrypted Password: $decrypted"),
          ],
        ),
      ),
    );
  }

  decryptPass(String encryptedPass) {
    String keyString = masterPassController.text;
    if (keyString.length < 32) {
      int count = 32 - keyString.length;
      for (var i = 0; i < count; i++) {
        keyString += ".";
      }
    }

    final iv = encrypt.IV.fromLength(16);
    final key = encrypt.Key.fromUtf8(keyString);

    try {
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final d = encrypter.decrypt64(encryptedPass, iv: iv);
      setState(() {
        decrypted = d;
      });
    } catch (exception) {
      setState(() {
       decrypted = "Wrong Master Password";
      });
    }
  }
}
