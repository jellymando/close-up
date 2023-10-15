import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:close_up/layout/main.dart';
import 'package:close_up/widgets/form.dart';
import 'package:close_up/widgets/button.dart';
import 'package:close_up/widgets/rating.dart';
import 'package:close_up/widgets/book_search.dart';
import 'package:close_up/pages/reviews.dart';

class ReviewWritePage extends StatefulWidget {
  const ReviewWritePage({Key? key}) : super(key: key);

  @override
  State<ReviewWritePage> createState() => _ReviewWritePageState();
}

class _ReviewWritePageState extends State<ReviewWritePage> {
  String _title = '';
  double _rating = 0.0;
  String _content = '';
  TextEditingController _textController = TextEditingController();

  void handleSelectBook(String bookName) {
    _textController.text = bookName;
    Navigator.of(context).pop();
  }

  void _updateRating(double value) {
    setState(() {
      _rating = value;
    });
  }

  void _showBookSearchAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            insetPadding: EdgeInsets.all(20),
            content: SingleChildScrollView(
                child: BookSearch(onSelectBook: handleSelectBook)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('닫기'),
              ),
            ]);
      },
    );
  }

  Future<void> _submitForm() async {
    Map<String, dynamic> reviewData = {
      'title': _title,
      'content': _content,
      'rating': _rating
    };
    print('reviewData: $reviewData');

    try {
      await FirebaseFirestore.instance.collection("reviews").add(reviewData);
      if (!context.mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ReviewPage()));
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: FormContainer(
          submitText: '등록하기',
          onSubmit: _submitForm,
          children: [
            Text('책 검색'),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onTap: _showBookSearchAlert,
                  ),
                ),
                SizedBox(width: 16.0),
                Button(
                    onPressed: _showBookSearchAlert,
                    child: Text('검색'),
                    isFill: false),
              ],
            ),
            SizedBox(height: 16.0),
            Text('제목'),
            TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '제목을 입력해주세요.';
                }
                return null;
              },
              onChanged: (String? value) {
                if (value != null) _title = value;
              },
            ),
            SizedBox(height: 16.0),
            Text('별점'),
            SizedBox(height: 10.0),
            Rating(
              rating: _rating,
              updateRating: _updateRating,
            ),
            SizedBox(height: 16.0),
            Text('내용'),
            TextFormField(
              maxLines: 4,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '내용을 입력해주세요.';
                }
                return null;
              },
              onChanged: (String? value) {
                if (value != null) _content = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
