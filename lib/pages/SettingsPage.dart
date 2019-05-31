import 'package:cipherly/pages/SetMasterPassword.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    

    return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              margin: EdgeInsets.only(top: size.height * 0.05),
              child: Text("Settings",
                  style: TextStyle(
                    fontFamily: "Title",
                    fontSize: 32,
                  ))),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SetMasterPassword()));
          },
          child: ListTile(
            title: Text(
              "Master Password",
              style: TextStyle(
                fontFamily: 'Title',
              ),
            ),
            subtitle: Text(
              "Change your Master Password",
              style: TextStyle(
                fontFamily: 'Subtitle',
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
