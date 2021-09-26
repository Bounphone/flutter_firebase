import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayScreen extends StatefulWidget {
  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Score Result'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("students").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children:
                snapshot.data!.docs.map((document) => Container(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(child: Text(document['score']),),
                    ),
                    title: Text(document['fName']+document['lName']),
                    subtitle: Text(document['email']),
                  ),
                )).toList(),
          );
        },
      ),
    );
  }
}
