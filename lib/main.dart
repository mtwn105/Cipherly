import 'package:cipherly/database/Database.dart';
import 'package:cipherly/pages/PasswordHomepage.dart';
import 'package:cipherly/pages/SetMasterPassword.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int launch = 0;
  bool loading = true;
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    launch = prefs.getInt("launch") ?? 0;
    if (launch == 0) {
      await prefs.setInt('launch', launch++);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    checkFirstSeen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cipherly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : launch == 0 ? SetMasterPassword() : PasswordHomepage(),
    );
  }
}
