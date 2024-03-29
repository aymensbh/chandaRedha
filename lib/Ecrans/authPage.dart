import 'package:flutter/material.dart';
import 'package:ichat_pfe/Index/login.dart';
import 'package:ichat_pfe/Index/signup.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xff303030),
          Color(0xff202020),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomPadding: false,
        body: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 8, left: 40, right: 40),
          // color: Color(0xFF383645),
          padding: MediaQuery.of(context).padding,
          child: Column(
            //work with design later
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      
                      Image.asset("assets/logo4.png",fit: BoxFit.cover,),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(bottom: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xff101010),
                            border: Border.all(color: Colors.white)
                            ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              splashColor: Colors.white,
                              onTap: () {
                                login(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height / 16,
                                child: Text("Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20)),
                              )),
                        )),
                    Container(
                        margin: EdgeInsets.only(bottom: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.black)),
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                              splashColor: Colors.white,
                              onTap: () {
                                signup(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height / 16,
                                child: Text("Signup",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Baloo",
                                        fontSize: 20)),
                              )),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
