import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:ichat_pfe/ClassAbstract/chat.dart';
import 'package:ichat_pfe/Utilities/BackendUtils.dart';
import 'package:ichat_pfe/tabs/chatPage.dart';
import 'package:ichat_pfe/widgets/messageTail.dart';

class MsgPage extends StatefulWidget {
  final String id;

  const MsgPage({Key key, this.id}) : super(key: key);

  @override
  _MsgPageState createState() => _MsgPageState();
}

class _MsgPageState extends State<MsgPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: FirebaseBackend().getUser(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return FirebaseAnimatedList(
                query: FirebaseBackend().base_chat.child(widget.id),
                sort: (a, b) =>
                    b.value["dateString"].compareTo(a.value["dateString"]),
                itemBuilder: (context, snapshot, animation, index) {
                  Chat chat = new Chat(snapshot);
                  String subtitle = (chat.id == widget.id) ? "you: " : "";
                  subtitle += chat.last_message ?? "image sent";
                  return MessageTail(
                      initials: chat.user.initiales,
                      imgUrl: chat.user.imgUrl,
                      lastMsg: 
                      // subtitle.length > 15
                      //     ? subtitle.substring(0, 15) + ".."
                      //     : 
                          subtitle,
                      name: chat.user.name,
                      time: chat.date,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => ChatPage(
                                    id: widget.id,
                                    partner: chat.user,
                                  ))));
                },
              );
            } else {
              return Center(
                child: Text(
                  "Loading messages..",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }
          },
        ));
  }
}

