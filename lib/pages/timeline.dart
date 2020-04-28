import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share_app/widgets/header.dart';
import 'package:share_app/widgets/progress.dart';

final CollectionReference usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<dynamic> users;

  @override
  void initState() {
    //createUser();
    super.initState();
  }

  createUser() {
    usersRef.document("asdasdasd").setData({
      "username": "Jeff",
      "postsCount": 0,
      "isAdmin": false,
    });
  }

  updateUser() {
    usersRef.document("asdasdasd").updateData({
      "username": "Jhon",
      "postsCount": 0,
      "isAdmin": false,
    });
  }

  deleteUser() {
    usersRef.document("asdasdasd").delete();
  }

  getUserById() async {
    final String id = "";
    final DocumentSnapshot doc = await usersRef.document(id).get();
    print(doc.data);
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: header(context, isAppTitle: true),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: usersRef.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return circularProgress();
                }

                final List<Text> children = snapshot.data.documents
                    .map((doc) => Text(doc["username"]))
                    .toList();
                return Container(
                  child: ListView(
                    children: children,
                  ),
                );
              }),
        ));
  }
}
