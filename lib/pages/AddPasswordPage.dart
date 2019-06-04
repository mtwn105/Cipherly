import 'dart:io';
import 'package:cipherly/database/Database.dart';
import 'package:cipherly/model/PasswordModel.dart';
import 'package:cipherly/pages/PasswordHomepage.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter/services.dart';

class AddPassword extends StatefulWidget {
  AddPassword({Key key}) : super(key: key);

  _AddPasswordState createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController appNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  encrypt.Encrypted encrypted;
  String keyString = "";
  String encryptedString = "";
  String decryptedString = "";
  String masterPassString = "";
  int pickedIcon;

  List<Icon> icons = [
    Icon(Icons.account_circle, size: 28, color: Colors.white),
    Icon(Icons.add, size: 28, color: Colors.white),
    Icon(Icons.access_alarms, size: 28, color: Colors.white),
    Icon(Icons.ac_unit, size: 28, color: Colors.white),
    Icon(Icons.accessible, size: 28, color: Colors.white),
    Icon(Icons.account_balance, size: 28, color: Colors.white),
    Icon(Icons.add_circle_outline, size: 28, color: Colors.white),
    Icon(Icons.airline_seat_individual_suite, size: 28, color: Colors.white),
    Icon(Icons.arrow_drop_down_circle, size: 28, color: Colors.white),
    Icon(Icons.assessment, size: 28, color: Colors.white),
  ];

  List<String> iconNames = [
    "Icon 1",
    "Icon 2",
    "Icon 3",
    "Icon 4",
    "Icon 5",
    "Icon 6",
    "Icon 7",
    "Icon 8",
    "Icon 9",
    "Icon 10",
  ];

  // Future<Null> getMasterPass() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String masterPass = prefs.getString('master') ?? "";
  //   masterPassString = masterPass;
  // }

  Future<Null> getMasterPass() async {
    final storage = new FlutterSecureStorage();
    String masterPass = await storage.read(key: 'master') ?? '';
    masterPassString = masterPass;
  }

  authenticate() async {
    try {
      var localAuth = LocalAuthentication();
      print(await localAuth.getAvailableBiometrics());
      bool didAuthenticate = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Please authenticate to add new password',
      );

      print(didAuthenticate);

      if (didAuthenticate == false) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => PasswordHomepage()),
            (Route<dynamic> route) => false);
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        // Handle this exception here.
      }
    }
  }

  Color pickedColor;
  var localAuth = LocalAuthentication();

  checkBiometrics() async {
    List<BiometricType> availableBiometrics;
    await localAuth.getAvailableBiometrics();

    if (Platform.isIOS) {
      if (availableBiometrics.contains(BiometricType.face)) {
        print('Face ID Avilabele');
        // Face ID.
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        // Touch ID.
      }
    } else if (Platform.isAndroid) {
      if (availableBiometrics.contains(BiometricType.fingerprint)) {
      } else if (availableBiometrics.contains(BiometricType.face)) {
      } else if (availableBiometrics.contains(BiometricType.iris)) {}
    }
  }

  @override
  void initState() {
    pickedColor = Colors.red;
    getMasterPass();
    pickedIcon = 0;
    // checkBiometrics();
    authenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.05),
                child: Text(
                  "Add Password",
                  style: TextStyle(
                      fontFamily: "Title", fontSize: 32, color: primaryColor),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter valid title';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Title",
                          labelStyle: TextStyle(fontFamily: "Subtitle"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16))),
                      controller: appNameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter valid Username';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "User Name/Email (if available)",
                          labelStyle: TextStyle(fontFamily: "Subtitle"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16))),
                      controller: userNameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter valid password';
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(fontFamily: "Subtitle"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16))),
                      controller: passwordController,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0),
                          child: Text(
                            "Pick an Icon",
                            style: TextStyle(
                                fontFamily: 'Title',
                                fontSize: 20,
                                color: primaryColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0),
                          child: Material(
                            shape: CircleBorder(),
                            elevation: 4.0,
                            child: CircleAvatar(
                                backgroundColor: pickedColor,
                                radius: 25,
                                child: icons[pickedIcon]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 0, 24, 10),
                    child: GridView.count(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 5,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1.3,
                        children: List.generate(icons.length, (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                pickedIcon = index;
                              });
                            },
                            child: Material(
                                elevation: 4.0,
                                color: pickedColor,
                                shape: CircleBorder(),
                                child: icons[index]),
                          );
                        })),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Pick a Color",
                            style: TextStyle(
                                fontFamily: 'Title',
                                fontSize: 20,
                                color: primaryColor),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _openColorPicker();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 8.0),
                            child: Material(
                                shape: CircleBorder(),
                                elevation: 4.0,
                                child: CircleAvatar(
                                  backgroundColor: pickedColor,
                                  radius: 25,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            encryptPass(passwordController.text);
            Password password = new Password(
                appName: appNameController.text,
                password: encryptedString,
                color: "#" + pickedColor.value.toRadixString(16),
                icon: iconNames[pickedIcon],
                userName: userNameController.text);
            DBProvider.db.newPassword(password);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => PasswordHomepage()),
                (Route<dynamic> route) => false);
          } else {
            // print(Theme.of(context).accentColor);
          }
        },
      ),
    );
  }

  _openColorPicker() async {
    Color _tempShadeColor = pickedColor;
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text("Color picker"),
          actions: [
            FlatButton(
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  pickedColor = _tempShadeColor;
                });
              },
            ),
          ],
          content: MaterialColorPicker(
            allowShades: true,
            selectedColor: _tempShadeColor,
            onColorChange: (color) => setState(() => _tempShadeColor = color),
            onMainColorChange: (color) =>
                setState(() => _tempShadeColor = color),
          ),
        );
      },
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
