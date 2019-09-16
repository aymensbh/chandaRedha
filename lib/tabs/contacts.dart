import 'package:flutter/material.dart';
import 'package:ichat_pfe/ClassAbstract/user.dart';
import 'package:ichat_pfe/Utilities/BackendUtils.dart';
import 'package:ichat_pfe/tabs/chatPage.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:ichat_pfe/widgets/userInfos.dart';

class Contacts extends StatefulWidget {
  final String id;

  const Contacts({Key key, this.id}) : super(key: key);

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: FirebaseBackend().getUser(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return FirebaseAnimatedList(
                query: FirebaseBackend().base_user,
                sort: (a, b) => a.value["name"].compareTo(b.value["name"]),
                itemBuilder: (context, snapshot, animation, index) {
                  User newUser = new User(snapshot);
                  if (newUser.id == widget.id)
                    return Container();
                  else {
                    print(newUser.imgUrl);
                    return UserInfos(
                      user: newUser,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => ChatPage(
                                    id: widget.id,
                                    partner: newUser,
                                  ))),
                    );
                  }
                },
              );
            } else {
              return Center(
                child: Text(
                  "Loading contacts..",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }
          },
        ));
  }
}
