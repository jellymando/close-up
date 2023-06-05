import 'package:flutter/material.dart';

import 'package:close_up/layout/write.dart';
import 'package:close_up/widgets/rating.dart';

class ReviewWritePage extends StatefulWidget {
  const ReviewWritePage({Key? key}) : super(key: key);

  @override
  State<ReviewWritePage> createState() => _ReviewWritePageState();
}

class _ReviewWritePageState extends State<ReviewWritePage> {
  String _bookSearch = '';
  String _title = '';
  double _rating = 0.0;
  String _content = '';

  void _updateRating(double value) {
    setState(() {
      _rating = value;
    });
  }

  void _submitForm() {
    // 폼 유효성 검사 통과 시 수행할 동작
    // 게시글을 제출하거나 다른 작업을 수행할 수 있습니다.
    // _bookSearch, _title, _rating, _content 값을 활용하세요.
    print('Book Search: $_bookSearch');
    print('Title: $_title');
    print('Rating: $_rating');
    print('Content: $_content');
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return WriteLayout(
        onSubmit: _submitForm,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: '책 검색',
                ),
                onChanged: (value) {
                  setState(() {
                    _bookSearch = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '제목',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '제목을 입력해주세요.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
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
              TextFormField(
                decoration: InputDecoration(
                  labelText: '내용',
                ),
                maxLines: 4,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '내용을 입력해주세요.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _content = value!;
                },
              ),
            ],
          ),
        ));
  }
}
