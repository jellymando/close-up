import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:close_up/layout/main.dart';

class SentencesPage extends StatefulWidget {
  const SentencesPage({Key? key}) : super(key: key);

  @override
  State<SentencesPage> createState() => _SentencesPageState();
}

class _SentencesPageState extends State<SentencesPage> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('sentences').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return Card(
                  color: Colors.white70,
                  child: Padding(
                      padding: EdgeInsets.all(6),
                      child: ListTile(
                        title: Text(data['content']),
                        subtitle: Text(data['bookName']),
                      )),
                );
              }).toList(),
            );
          }),
    );
  }
}
