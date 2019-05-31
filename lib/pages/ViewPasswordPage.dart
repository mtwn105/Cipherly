import 'package:cipherly/model/PasswordModel.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:sqflite/utils/utils.dart';

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

  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<Icon> icons = [
    Icon(Icons.account_circle, size: 64, color: Colors.white),
    Icon(Icons.add, size: 64, color: Colors.white),
    Icon(Icons.access_alarms, size: 64, color: Colors.white),
    Icon(Icons.ac_unit, size: 64, color: Colors.white),
    Icon(Icons.accessible, size: 64, color: Colors.white),
    Icon(Icons.account_balance, size: 64, color: Colors.white),
    Icon(Icons.add_circle_outline, size: 64, color: Colors.white),
    Icon(Icons.airline_seat_individual_suite, size: 64, color: Colors.white),
    Icon(Icons.arrow_drop_down_circle, size: 64, color: Colors.white),
    Icon(Icons.assessment, size: 64, color: Colors.white),
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
  bool decrypt = false;
  String decrypted = "";
  Color color;
  int index;
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 9), radix: 16) + 0xFF000000);
  }

  @override
  void initState() {
    print(password.color);
    color = hexToColor(password.color);
    index = iconNames.indexOf(password.icon);
    // while (index < iconNames.length) {
    //   if (password.icon == iconNames[index]) {
    //     break;
    //   }
    //   index++;
    // }
    print(color);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      key: scaffoldKey,
      // backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              height: size.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    icons[index],
                    SizedBox(
                      height: 12,
                    ),
                    Text(password.appName,
                        style: TextStyle(
                            fontFamily: "Title",
                            fontSize: 32,
                            color: Colors.white)),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Username",
                    style: TextStyle(fontFamily: 'Title', fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                  child: Text(
                    password.userName,
                    style: TextStyle(
                        fontFamily: 'Subtitle',
                        fontSize: 20,
                        // color: Colors.black54
                        ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Password",
                            style: TextStyle(
                                fontFamily: 'Title', fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                          child: Text(
                            decrypt ? decrypted : password.password,
                            style: TextStyle(
                                fontFamily: 'Subtitle',
                                fontSize: 20,
                                // color: Colors.black54
                                ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        if (!decrypt) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Enter Master Password"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "To decrypt the password enter your master password:",
                                        style: TextStyle(
                                            fontFamily: 'Subtitle',
                                            color: Colors.black54),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          obscureText: true,
                                          maxLength: 32,
                                          decoration: InputDecoration(
                                              hintText: "Master Pass",
                                              hintStyle: TextStyle(
                                                  fontFamily: "Subtitle"),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16))),
                                          controller: masterPassController,
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        decryptPass(password.password);
                                        if (!decrypt) {
                                          final snackBar = SnackBar(
                                              content: Text(
                                                  'Wrong Master Password',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "Subtitle")));

                                          scaffoldKey.currentState
                                              .showSnackBar(snackBar);
                                        }
                                      },
                                      child: Text("DONE"),
                                    )
                                  ],
                                );
                              });
                        }
                      },
                      icon: decrypt
                          ? Icon(Icons.lock_open)
                          : Icon(Icons.lock),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
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
        decrypt = true;
      });
    } catch (exception) {
      setState(() {
        decrypted = "Wrong Master Password";
      });
    }
  }
}
