import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ichat_pfe/Ecrans/authPage.dart';
import 'package:ichat_pfe/Ecrans/homePage.dart';
import 'package:flutter/services.dart';

void main(List<String> args) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // systemNavigationBarColor: Colors.transparent
    // systemNavigationBarDividerColor: Colors.transparent
  ));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Router(),
    theme: ThemeData(
      primaryTextTheme: TextTheme(
        body1: TextStyle(fontFamily: "panda"),
        body2: TextStyle(fontFamily: "panda"),
        button: TextStyle(fontFamily: "panda"),
        caption: TextStyle(fontFamily: "panda"),
        display1: TextStyle(fontFamily: "panda"),
        display2: TextStyle(fontFamily: "panda"),
        display3: TextStyle(fontFamily: "panda"),
        display4: TextStyle(fontFamily: "panda"),
        headline: TextStyle(fontFamily: "panda"),
        overline: TextStyle(fontFamily: "panda"),
        subhead: TextStyle(fontFamily: "panda"),
        subtitle: TextStyle(fontFamily: "panda"),
        title: TextStyle(fontFamily: "panda"),
      ),
      accentTextTheme: TextTheme(
        body1: TextStyle(fontFamily: "panda"),
        body2: TextStyle(fontFamily: "panda"),
        button: TextStyle(fontFamily: "panda"),
        caption: TextStyle(fontFamily: "panda"),
        display1: TextStyle(fontFamily: "panda"),
        display2: TextStyle(fontFamily: "panda"),
        display3: TextStyle(fontFamily: "panda"),
        display4: TextStyle(fontFamily: "panda"),
        headline: TextStyle(fontFamily: "panda"),
        overline: TextStyle(fontFamily: "panda"),
        subhead: TextStyle(fontFamily: "panda"),
        subtitle: TextStyle(fontFamily: "panda"),
        title: TextStyle(fontFamily: "panda"),
      ),
        textTheme: TextTheme(
        body1: TextStyle(fontFamily: "panda"),
        body2: TextStyle(fontFamily: "panda"),
        button: TextStyle(fontFamily: "panda"),
        title: TextStyle(fontFamily: "panda"),
        subtitle: TextStyle(fontFamily: "panda"),
        display1: TextStyle(fontFamily: "panda"),
        display2: TextStyle(fontFamily: "panda"),
        display3: TextStyle(fontFamily: "panda"),
        caption: TextStyle(fontFamily: "panda"),
        display4: TextStyle(fontFamily: "panda"),
        headline: TextStyle(fontFamily: "panda"),
        overline: TextStyle(fontFamily: "panda"),
        subhead: TextStyle(fontFamily: "panda"),
        ),
        accentColor: Color(0xff202020),
        canvasColor: Color(0xff202020),
        backgroundColor: Color(0xff202020),
        tabBarTheme: TabBarTheme(

        ),),
  ));
}
class Router extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData)
          return HomePage();
        else
          return AuthPage();
      },
    );
  }
}
