import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:close_up/layout/layout.dart';

class SentencesPage extends StatefulWidget {
  const SentencesPage({Key? key}) : super(key: key);

  @override
  State<SentencesPage> createState() => _SentencesPageState();
}

class _SentencesPageState extends State<SentencesPage> {
  List sentences = [];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('sentences').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            final documents = snapshot.data?.docs;

            return Expanded(
                child: ListView.builder(
              itemCount: documents?.length,
              itemBuilder: (BuildContext context, int index) {
                final document = documents?[index].data();
                final content = (document as Map<String, dynamic>)['content'];
                return ListTile(
                  title: Text(content),
                );
              },
            ));
          }),
    );
  }
}
