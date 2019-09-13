import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ichat_pfe/entities/user.dart';
import 'package:ichat_pfe/util/firebaseUtils.dart';
import 'package:ichat_pfe/widgets/editpassword.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';


class Profile extends StatefulWidget {
  final String id;

  const Profile({Key key, this.id}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user;

  @override
  void initState() {
    FirebaseUtils().getUser(widget.id).then((onValue) {
      setState(() {
        user = onValue;
      });
      //  print(user.imgUrl);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right:30,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        backgroundColor: Color(0xff202020),
        // resizeToAvoidBottomInset: false,
        // resizeToAvoidBottomPadding: false,
        body: FutureBuilder(
          future: FirebaseUtils().getUser(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  GestureDetector(
                    onTap: () => _takePicture(ImageSource.gallery),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          )
                        ),
                          child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Text(user.initiales,
                                      style: TextStyle(
                                          color: Color(0xff505050),
                                          fontSize:
                                              MediaQuery.of(context).size.width /
                                                  5)),
                                  radius: MediaQuery.of(context).size.width / 4,
                                )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  // Divider(
                  //   color: Colors.white.withOpacity(.2),
                  //   height: 1.5,
                  // ),
                  Center(
                    child: Container(
                      child: Text(
                        user.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        user.email,
                        style: TextStyle(
                            color: Colors.white.withOpacity(.5),
                            fontSize: MediaQuery.of(context).size.width / 22),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.height / 22),
                  ),
                  Divider(
                    color: Colors.white.withOpacity(.2),
                    height: 1.5,
                  ),
                  Container(
                    child: ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                new EditPassword());
                      },
                      leading: CircleAvatar(
                        backgroundColor: Color(0xff505050),
                        foregroundColor: Colors.white,
                        radius: 28,
                        child: Icon(Icons.lock_outline),
                      ),
                      title: Text("Change Password",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 20)),
                      subtitle: Text("press to update password",
                          style: TextStyle(
                              color: Colors.white.withOpacity(.6),
                              fontSize: MediaQuery.of(context).size.width / 28)),
                    ),
                  ),
                  
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Divider(
                    color: Colors.white.withOpacity(.2),
                    height: 1.5,
                  ),
                  Container(
                    child: ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(
                                    "Delete account?",
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                        child: Text("Cancel"),
                                        onPressed: () => Navigator.pop(context)),
                                    FlatButton(
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () => FirebaseUtils()
                                                .deleteUser(widget.id)
                                                .then((onValue) {
                                              Navigator.pop(context);
                                            }).catchError((onError) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      SimpleDialog(
                                                        title: Text(
                                                            "Somthig went wrong!"),
                                                        children: <Widget>[
                                                          Text(
                                                              "Could not delete account..")
                                                        ],
                                                      ));
                                            })),
                                  ],
                                ));
                      },
                      leading: CircleAvatar(
                        backgroundColor: Color(0xff505050),
                        foregroundColor: Colors.white,
                        radius: 28,
                        child: Icon(Icons.delete_outline),
                      ),
                      title: Text("Delete Account",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 20)),
                      subtitle: Text("delete all your informations",
                          style: TextStyle(
                              color: Colors.white.withOpacity(.6),
                              fontSize: MediaQuery.of(context).size.width / 28)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Divider(
                    color: Colors.white.withOpacity(.2),
                    height: 1.5,
                  ),
                  Container(
                    child: ListTile(
                      onTap: () {
                        FirebaseUtils().logOut();
                      },
                      leading: CircleAvatar(
                        backgroundColor: Color(0xff505050),
                        foregroundColor: Colors.white,
                        radius: 28,
                        child: Icon(LineIcons.sign_out),
                      ),
                      title: Text("Log out",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 20)),
                      subtitle: Text("Disconnect your account",
                          style: TextStyle(
                              color: Colors.white.withOpacity(.6),
                              fontSize: MediaQuery.of(context).size.width / 28)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),

                  
                  Divider(
                    color: Colors.white.withOpacity(.2),
                    height: 1.5,
                  ),

                ],
              );
            } else {
              return Center(
                child: Text(
                  "Loading profile..",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _takePicture(ImageSource source) async {
    File image;
    image = await ImagePicker.pickImage(
        source: source, maxWidth: 500.0, maxHeight: 500.0);
    FirebaseUtils()
        .savePicture(image, FirebaseUtils().storage_users.child(widget.id))
        .then((string) async {
      await FirebaseUtils().base_user.child(user.id).update({"imgUrl": string});
      // Map map = user.toMap();
      // map["imgUrl"] = string;
      // FirebaseUtils().addUser(user.id, map);
      FirebaseUtils().getUser(widget.id).then((onValue) {
        setState(() {
          user = onValue;
        });
        //  print(user.imgUrl);
      });
    });
  }
}
