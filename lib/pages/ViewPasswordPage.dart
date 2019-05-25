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

  String decrypted = "";
  final key = encrypt.Key.fromUtf8('my 32 length key................');
  

  @override
  void initState() {
    decryptPass(password.password);
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
            Text("App Name: ${password.appName}"),
            Text("Password: ${password.password}"),
            Text("Decrypted Password: $decrypted"),
          ],
        ),
      ),
    );
  }
   decryptPass(String encryptedPass) {
    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final d = encrypter.decrypt64(encryptedPass, iv: iv);
setState(() {
 decrypted = d; 
});
  }
}
