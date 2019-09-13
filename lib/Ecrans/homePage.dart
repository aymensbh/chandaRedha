import 'package:flutter/material.dart';
import 'package:ichat_pfe/tabs/contacts.dart';
import 'package:ichat_pfe/tabs/msgpage.dart';
import 'package:ichat_pfe/tabs/profile.dart';
import 'package:ichat_pfe/utilities/firebaseUtils.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String id;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2, initialIndex: 0);
    FirebaseUtils().myId().then((uid) async {
      setState(() {
        id = uid;
      });

      await FirebaseUtils().base_user.child(id).update({"isActive": "Active"});
    });

    super.initState();
  }

  void _showGithubDialog() async {
    const url = 'https://github.com/aymensbh/ichat_pfe';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showAboutDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "About Project: iChat!",
            ),
            content: Text(
              "Products used Flutter & Firebase Paticipants: Sebihi Abdelkader & Merouani Abdenour thank you",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Ok",
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  // @override
  // void dispose() async {
  //   _tabController.dispose();
  //   await FirebaseUtils().base_user.child(id).update({"isActive": ""});
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xff202020), Color(0xff000000)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: FutureBuilder(
        future: FirebaseUtils().firebaseAuth.currentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              drawer: Profile(id: id),
              resizeToAvoidBottomPadding: true,
              // backgroundColor: Color(0xff1CD8D2),
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                // backgroundColor: Color(0xff1CD8D2),
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text("Tchanda"),
              ),
              bottomNavigationBar: TabBar(
                  indicatorColor: Colors.white.withOpacity(.8),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  indicatorWeight: 3,
                  
                  indicatorPadding: EdgeInsets.all(4),
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.chat_bubble_outline),
                    ),
                    Tab(
                      icon: Icon(Icons.people_outline),
                    ),
                    // Tab(
                    //   text: "Profile",
                    //   icon: Icon(LineIcons.user),
                    // )
                  ],
                ),
              body: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  MsgPage(id: id),
                  Contacts(id: id),
                ],
              ),
            );
          } else {
            return Scaffold(
                resizeToAvoidBottomPadding: true,
                // backgroundColor: Color(0xff1CD8D2),
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  // backgroundColor: Color(0xff1CD8D2),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text("Loading.."),
                  actions: <Widget>[
                    PopupMenuButton(
                      onSelected: (value) {
                        if (value == 3) {}
                      },
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("About"),
                                  Icon(
                                    Icons.help_outline,
                                    color: Colors.orange,
                                  )
                                ],
                              ),
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Github"),
                                  Icon(
                                    LineIcons.github,
                                    color: Colors.green,
                                  )
                                ],
                              ),
                              value: 2,
                            ),
                            PopupMenuItem(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Logout"),
                                  Icon(
                                    Icons.exit_to_app,
                                    color: Colors.redAccent,
                                  )
                                ],
                              ),
                              value: 3,
                            )
                          ],
                    )
                  ],
                ),
                body: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      "Loading..",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ));
          }
        },
      ),
    );
  }
}
