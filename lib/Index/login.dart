import 'package:flutter/material.dart';
import 'package:ichat_pfe/Utilities/BackendUtils.dart';

String _email, _password;

final formKey = GlobalKey<FormState>();
void login(BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          elevation: 1,
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          title: Text(
            "Login",
            style: TextStyle( fontSize: 28,color: Colors.black.withOpacity(.6)),
          ),
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 4),
                    child: TextFormField(
                      onSaved: (input) {
                        _email = input.trim();
                      },
                      validator: (input) {
                        if (input.isEmpty) return 'Provide an email';
                      },
                      cursorColor: Color(0xFF383645),
                      cursorWidth: 1,
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(240, 240, 240, .8),
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 12, right: 6),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey)
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: TextFormField(
                      obscureText: true,
                      onSaved: (input) {
                        _password = input;
                      },
                      validator: (input) {
                        if (input.length < 6) return 'Provide 6 characters';
                      },
                      cursorColor: Color(0xFF383645),
                      cursorWidth: 1,
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(240, 240, 240, .8),
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 12, right: 6),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              elevation: 0,
              textColor: Colors.white,
              color: Color(0xff202020),
              child: Text("Get Started",),
              onPressed: () {
                validate(context);
              },
            ),
          ],
        );
      });
}

Future<void> validate(BuildContext context) async {
  BuildContext dialogCtx;
  print("object");
  if (formKey.currentState.validate()) {
    formKey.currentState.save();
    showDialog(
        context: context,
        builder: (dcontext) {
          dialogCtx = dcontext;
          return SimpleDialog(
            title: Text("Loading.."),
            titlePadding: EdgeInsets.all(12),
            contentPadding: EdgeInsets.all(16),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  strokeWidth: 3,                  
                ),
              )
            ],
          );
        });
    FirebaseBackend().signIn(_email, _password).then((onValue) {
      Navigator.of(dialogCtx).pop(true);
      Navigator.pop(context);
    }).catchError((onError) {
      Navigator.of(dialogCtx).pop(true);
      print(onError);
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              title: Text("Login error!"),
              children: <Widget>[
                Text("Failed to log you in with these email & password"),
              ],
            );
          });
    });
  }
}
