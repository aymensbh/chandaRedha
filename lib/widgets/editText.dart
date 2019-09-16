import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ichat_pfe/ClassAbstract/user.dart';
import 'package:ichat_pfe/Utilities/BackendUtils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';


class EditText extends StatefulWidget {
  final User partner;
  final String id;

  const EditText({Key key, this.partner, this.id}) : super(key: key);

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  TextEditingController _textEditingController;
  User me;

  @override
  void initState() {
    _textEditingController = new TextEditingController();

    FirebaseBackend().getUser(widget.id).then((user) {
      setState(() {
        me = user;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      child: Row(
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.all(10),
          // ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: IconButton(
              icon: Icon(
                LineIcons.photo,
                color: Colors.white
              ),
              onPressed: () {
                takePicture(ImageSource.gallery);
              },
            ),
          ),
          Expanded(
            child: Container(
              child: TextField(
                controller: _textEditingController,
                cursorWidth: 1,
                cursorColor: Colors.grey,
                style: TextStyle(
                  color: Colors.white,
                    // fontFamily: 'product'
                    ),
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.all(
                        10), //--------------------------------------------
                    hintText: 'Type a message',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      // fontFamily: 'product'
                    ),
                    fillColor: Color(0xff202020),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff4e54c8).withOpacity(.2),
                         width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff4e54c8).withOpacity(.2),
                         width: 1),
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: IconButton(
              icon: Icon(
                LineIcons.share,
                color: Colors.white,
              ),
              onPressed: _sendButtonPressed(),
            ),
          )
        ],
      ),
    );
  }

  _sendButtonPressed() {
    if (_textEditingController.text != null &&
        _textEditingController.text != "") {
      String text = _textEditingController.text;
      FirebaseBackend().sendMessage(widget.partner, me, text, null);
      _textEditingController.clear();
      // FocusScope.of(context).requestFocus(new FocusNode());
    } else {
      print("null");
    }
  }

  Future<void> takePicture(ImageSource source) async {
    File file = await ImagePicker.pickImage(
        source: source, maxWidth: 1000.0, maxHeight: 1000.0);
    String date = new DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseBackend()
        .savePicture(
            file, FirebaseBackend().storage_messages.child(widget.id).child(date))
        .then((string) {
      FirebaseBackend().sendMessage(widget.partner, me, null, string);
    });
  }
}
