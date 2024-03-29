import 'package:flutter/material.dart';

class MessageTail extends StatefulWidget {
  final String initials, lastMsg, name, time, imgUrl;
  final GestureTapCallback onTap;

  const MessageTail({
    Key key,
    this.initials,
    this.lastMsg,
    this.name,
    this.time,
    this.onTap,
    this.imgUrl,
  }) : super(key: key);

  @override
  _MessageTailState createState() => _MessageTailState();
}

class _MessageTailState extends State<MessageTail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.imgUrl);
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.only(top: 6, bottom: 6),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.04),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListTile(
        leading: Container(
          child: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xff202020),
                  child: Text(widget.initials),
                  maxRadius: 28,
                )
        ),
        title: Text(widget.name,
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width / 18)),
        subtitle: Text(widget.lastMsg,
            style: TextStyle(
                color: Colors.white.withOpacity(.6),
                fontSize: MediaQuery.of(context).size.width / 26)),
        trailing: Text(widget.time,
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width / 24)),
        onTap: widget.onTap,
      ),
    );
  }
}
