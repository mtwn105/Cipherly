import 'package:cipherly/pages/SetMasterPassword.dart';
import 'package:flutter/material.dart';

class GreetingsPage extends StatefulWidget {
  @override
  _GreetingsPageState createState() => _GreetingsPageState();
}

class _GreetingsPageState extends State<GreetingsPage> {


  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 3),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             Image.asset("assets/key.png",height: size.height*0.3,),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8, 24, 8),
                child: Text("Welcome to Cipherly!",                    
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "Title", fontSize: 36)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8, 24, 8),
                child: Text(
                    "Cipherly takes care of your sensitive password data using AES encryption.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Subtitle",
                        fontSize: 18,
                        // color: Colors.black54
                        ),
                        ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8, 24, 8),
                child: Text("Set your master password to get started!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "Subtitle", fontSize: 24)),
              ), Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8, 24, 8),
                child: Text(
                    "(You can change it afterwards)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Subtitle",
                        fontSize: 18,
                        // color: Colors.black54
                        ),
                        ),
              ),SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: size.width * 0.7,
                child: MaterialButton(
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)
                  ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SetMasterPassword()));
                    },
                    color: primaryColor,
                    child: Text("Get Started",
                        style: TextStyle(color: Colors.white))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
