import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:ichat_pfe/ClassAbstract/message.dart';
import 'package:ichat_pfe/ClassAbstract/user.dart';
import 'package:ichat_pfe/Utilities/BackendUtils.dart';
import 'package:ichat_pfe/widgets/editText.dart';
import 'package:ichat_pfe/widgets/messageList.dart';

class ChatPage extends StatefulWidget {
  final String id;
  final User partner;

  const ChatPage({Key key, this.id, this.partner}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.white),
            onPressed: () async {
                FirebaseBackend().deleteChat(widget.id, widget.partner.id);
                Navigator.pop(context);
            },
          )
        ],
        elevation: 2,
        backgroundColor: Color(0xff202020),
        title: Text(widget.partner.name),
      ),
      body: Container(
        color: Color(0xff404040),
        child: InkWell(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Column(
            children: <Widget>[
              Flexible(
                child: FirebaseAnimatedList(
                  query: FirebaseBackend()
                      .base_message
                      .child(FirebaseBackend()
                          .getMessageRef(widget.id, widget.partner.id))
                      .limitToLast(40),
                  reverse: true,
                  sort: (a, b) => b.key.compareTo(a.key),
                  itemBuilder: (context, snapshot, animation, index) {
                    Message message = new Message(snapshot);
                    print("from" + snapshot.value["dateString"]);
                    return GestureDetector(
                      child: ChatContainer(
                        myid: widget.id,
                        partner: widget.partner,
                        message: message,
                        animation: animation,
                      ),
                      onLongPress: () {},
                    );
                  },
                ),
              ),
              new Divider(
                height: 2,
                color: Color(0xff4e54c8).withOpacity(.2),
              ),
              new EditText(
                partner: widget.partner,
                id: widget.id,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
