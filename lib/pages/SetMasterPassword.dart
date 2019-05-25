import 'package:cipherly/pages/PasswordHomepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetMasterPassword extends StatefulWidget {
  @override
  _SetMasterPasswordState createState() => _SetMasterPasswordState();
}

class _SetMasterPasswordState extends State<SetMasterPassword> {
  TextEditingController masterPassController = TextEditingController();

  Future<Null> getMasterPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String masterPass = prefs.getString('master') ?? "";
    masterPassController.text = masterPass;
  }

  @override
  void initState() {
    super.initState();
    getMasterPass();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Master Password"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Set Master Passwords for your all passwords",
                  style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontFamily: "Subtitle"))),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                maxLength: 32,
                decoration: InputDecoration(
                    hintText: "Master Pass",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
                controller: masterPassController,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: MaterialButton(
              color: Colors.blue,
              child: Text(
                "CONFIRM",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('master', masterPassController.text);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => PasswordHomepage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
