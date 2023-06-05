import 'package:flutter/material.dart';

import 'package:close_up/layout/main.dart';

class WriteLayout extends StatelessWidget {
  final Widget child;
  final void Function() onSubmit;
  const WriteLayout({Key? key, required this.child, required this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: child,
            ),
          ),
          ElevatedButton(
            onPressed: onSubmit,
            child: Text('등록하기'),
          ),
        ],
      ),
    );
  }
}
