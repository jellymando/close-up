import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:close_up/widgets/button.dart';

class BookSearch extends StatefulWidget {
  final void Function(String)? onSelectBook;

  const BookSearch({Key? key, this.onSelectBook}) : super(key: key);

  @override
  State<BookSearch> createState() => _BookSearchState();
}

class _BookSearchState extends State<BookSearch> {
  String _bookName = '';
  List _bookList = [];

  Future<void> _searchBook() async {
    print(_bookName);
    if (_bookName == '') return;

    final url = Uri.parse(
        'http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=ttbcicikdi1602001&Query=$_bookName&QueryType=Title&MaxResults=10&start=1&SearchTarget=Book&output=js&Version=20131101');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Request successful
      final responseBody = json.decode(response.body);
      final items = responseBody['item'];
      // print(items);
      if (items.length > 0) {
        setState(() {
          _bookList = items;
        });
      }
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('책 검색'),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (String? value) {
                      if (value != null) _bookName = value;
                    },
                  ),
                ),
                SizedBox(width: 16.0),
                Button(
                    onPressed: _searchBook, child: Text('검색'), isFill: false),
              ],
            ),
            if (_bookList.isNotEmpty)
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: 26.0),
                Text('조회 결과'),
                SizedBox(height: 10.0),
                ..._bookList.map(
                  (book) {
                    return Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          // Card 대신 InkWell 사용
                          onTap: () => widget.onSelectBook!(book['title']),
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 4, 2, 4),
                              child: ListTile(
                                leading:
                                    Image.network(book['cover'], width: 35),
                                title: Text(
                                  book['title'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(book['author'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              )),
                        )),
                      ],
                    );
                  },
                )
              ])
          ],
        ));
  }
}
