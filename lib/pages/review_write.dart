import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:close_up/layout/write.dart';
import 'package:close_up/widgets/rating.dart';
import 'package:close_up/pages/reviews.dart';

class ReviewWritePage extends StatefulWidget {
  const ReviewWritePage({Key? key}) : super(key: key);

  @override
  State<ReviewWritePage> createState() => _ReviewWritePageState();
}

class _ReviewWritePageState extends State<ReviewWritePage> {
  String? _bookSearch;
  String? _title;
  double _rating = 0.0;
  String? _content;

  void _updateRating(double value) {
    setState(() {
      _rating = value;
    });
  }

  Future<void> _submitForm() async {
    print('Book Search: $_bookSearch');
    print('Title: $_title');
    print('Rating: $_rating');
    print('Content: $_content');

    Map<String, dynamic> reviewData = {
      'title': _title,
      'content': _content,
      'rating': _rating
    };
    try {
      await FirebaseFirestore.instance.collection("reviews").add(reviewData);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ReviewPage()));
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WriteLayout(
      onSubmit: _submitForm,
      children: [
        Text('책 검색'),
        TextFormField(
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return '책을 검색해주세요.';
            }
            return null;
          },
          onChanged: (String? value) {
            _bookSearch = value;
          },
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
            _title = value;
          },
        ),
        SizedBox(height: 16.0),
        Text('별점'),
        SizedBox(height: 16.0),
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
            _content = value;
          },
        ),
      ],
    );
  }
}
