import 'package:cipherly/database/Database.dart';
import 'package:cipherly/pages/PasswordHomepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cipherly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PasswordHomepage(),
    );
  }
}
