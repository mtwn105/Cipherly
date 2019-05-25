import 'dart:math';

import 'package:cipherly/bloc/PasswordBloc.dart';
import 'package:cipherly/database/Database.dart';
import 'package:cipherly/model/PasswordModel.dart';
import 'package:cipherly/pages/ViewPasswordPage.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import 'AddPasswordPage.dart';
import 'SettingsPage.dart';

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
    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Container(
                margin: EdgeInsets.only(top: size.height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Cipherly",
                        style: TextStyle(
                          fontFamily: "Title",
                          fontSize: 32,
                          color: primaryColor
                        )),
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SettingsPage()));
                      },
                    )
                  ],
                )),
          ),
          Expanded(
            child: StreamBuilder<List<Password>>(
              stream: bloc.passwords,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length > 0) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Password password = snapshot.data[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ViewPassword(
                                          password: password,
                                        )));
                          },
                          child: ListTile(
                            title: Text(
                              password.appName,
                              style: TextStyle(
                                fontFamily: 'Title',
                              ),
                            ),
                            leading: Container(
                                height: 36,
                                width: 36,
                                child: Icon(Icons.account_circle,
                                    size: 36, color: Colors.black)),
                            subtitle: password.userName != ""
                                ? Text(
                                    password.userName,
                                    style: TextStyle(
                                      fontFamily: 'Subtitle',
                                    ),
                                  )
                                : Text(
                                    "No username specified",
                                    style: TextStyle(
                                      fontFamily: 'Subtitle',
                                    ),
                                  ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No Passwords Saved. \nClick \"+\" button to add a password",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54),
                      ),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
backgroundColor: primaryColor,
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
