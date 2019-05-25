import 'dart:math';

import 'package:cipherly/bloc/PasswordBloc.dart';
import 'package:cipherly/database/Database.dart';
import 'package:cipherly/model/PasswordModel.dart';
import 'package:cipherly/pages/ViewPasswordPage.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import 'AddPasswordPage.dart';

class PasswordHomepage extends StatefulWidget {
  @override
  _PasswordHomepageState createState() => _PasswordHomepageState();
}

class _PasswordHomepageState extends State<PasswordHomepage> {
  final bloc = PasswordBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("cipherly"),
      ),
      body: StreamBuilder<List<Password>>(
        stream: bloc.passwords,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Password password = snapshot.data[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ViewPassword(
                                  password: password,
                                )));
                  },
                  child: ListTile(
                    title: Text(password.appName),
                    leading: Text(password.id.toString()),
                    subtitle: Text(password.password),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddPassword()));
        },
      ),
    );
  }
}
