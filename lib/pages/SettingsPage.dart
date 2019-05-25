import 'package:cipherly/pages/SetMasterPassword.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Settings")),
        body: Column(
          children: <Widget>[
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
            )
          ],
        ));
  }
}
