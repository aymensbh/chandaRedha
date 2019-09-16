import 'package:flutter/material.dart';
import 'package:ichat_pfe/Utilities/BackendUtils.dart';


class EditPassword extends StatefulWidget {
  @override
  EditPasswordState createState() {
    return EditPasswordState();
  }
}

class EditPasswordState extends State<EditPassword> {
  final formKey = GlobalKey<FormState>();
  String _password;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Reset password",
      ),
      content: Container(
        padding: EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: TextFormField(
            onSaved: (input) {
              _password = input;
            },
            validator: (input) {
              if (input.length < 6) {
                return "provide more than 6 characters";
              }
            },
            cursorWidth: 1,
            style: TextStyle(
                ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(12),
              filled: true,
              hintText: 'Aa',
              hintStyle: TextStyle(
                  ),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            // style: TextStyle(color: KColors.fourth),
          ),
        ),
        FlatButton(
          onPressed: edit,
          child: Text(
            "Reset",
            style: TextStyle(color: Colors.green),
          ),
        )
      ],
    );
  }

  Future<void> edit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      FirebaseBackend().updatePassword(_password);
      Navigator.pop(context);
    }
  }
}
