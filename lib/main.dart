import 'package:cipherly/database/Database.dart';
import 'package:cipherly/pages/GreetingsPage.dart';
import 'package:cipherly/pages/PasswordHomepage.dart';
import 'package:cipherly/pages/SetMasterPassword.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

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
  // bool enableDarkTheme = false;
  // Brightness brightness = Brightness.light;

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    launch = prefs.getInt("launch") ?? 0;
    // enableDarkTheme = prefs.getBool('enableDarkTheme') ?? false;

    if (launch == 0) {
      await prefs.setInt('launch', launch+1);
      await prefs.setBool('enableDarkTheme', false);
    }

    // if (enableDarkTheme) {
    //     setState(() {
    //       brightness = Brightness.dark;
    //     });
    //   } else {
    //     setState(() {
    //       brightness = Brightness.light;
    //     });
    //   }

    setState(() {
      loading = false;
    });
  }

  // ThemeData lightTheme = ThemeData(
  //       fontFamily: "Title",
  //       primaryColor: Color(0xff5153FF),
  //       primaryColorDark: Color(0xff0029cb),
  //       brightness: Brightness.dark
  //     );

  // ThemeData darkTheme = ThemeData.dark().copyWith(
    
  //       primaryColor: Color(0xff5153FF),
  //       primaryColorDark: Color(0xff0029cb)
  //     );

  @override
  void initState() {
    checkFirstSeen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData(
        fontFamily: "Title",
        primaryColor: Color(0xff5153FF),
        primaryColorDark: Color(0xff0029cb),
        brightness: brightness,
      ),
        themedWidgetBuilder: (context, theme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cipherly',
        // theme: enableDarkTheme ? darkTheme : lightTheme,
        theme: theme,
        home: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : launch == 0 ? GreetingsPage() : PasswordHomepage(),
      ),
    );
  }
}
