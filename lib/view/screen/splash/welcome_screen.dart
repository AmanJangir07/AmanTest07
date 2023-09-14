import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/provider/auth_provider.dart';
import 'package:shopiana/provider/splash_provider.dart';
import 'package:shopiana/view/screen/auth/auth_screen.dart';
import 'package:shopiana/view/screen/dashboard/dashboard_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? greetingMsg;
  void initialConfig() async {
    // await Provider.of<SplashProvider>(context, listen: false)
    //     .initSharedPrefData();
    // get cart data

    Timer(Duration(seconds: 2), () {
      if (Provider.of<SplashProvider>(context, listen: false).allowGuestUser) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DashBoardScreen()));
      }
      if (!Provider.of<SplashProvider>(context, listen: false).allowGuestUser &&
          !Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AuthScreen()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => DashBoardScreen()));
      }
    });
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return greetingMsg = 'MORNING';
    }
    if (hour < 17) {
      return greetingMsg = 'AFTERNOON';
    }
    return greetingMsg = 'EVENING';
  }

  @override
  void initState() {
    super.initState();
    NetworkInfo.checkConnectivity(context);
    initialConfig();
    greeting();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: _height * 0.4),
        child: Center(
          child: Column(children: [
            Text(
              "GOOD " + '$greetingMsg'.toString(),
              style: TextStyle(
                  fontSize: _width * 0.05, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: _height * 0.02,
            ),
            Text("Welcome to",
                style: TextStyle(
                    fontSize: _width * 0.03, fontWeight: FontWeight.bold)),
            Text(" Sleepin Saathi",
                style: TextStyle(
                    fontSize: _width * 0.03, fontWeight: FontWeight.bold))
          ]),
        ),
      ),
    );
  }
}
