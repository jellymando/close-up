import 'package:flutter/material.dart';

import 'package:close_up/layout/main.dart';

class WriteLayout extends StatelessWidget {
  final List<Widget> children;
  final void Function() onSubmit;
  const WriteLayout({Key? key, required this.children, required this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return MainLayout(
        child: Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...children,
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  onSubmit();
                }
              },
              child: Text('등록하기'),
            )
          ],
        ),
      ),
    ));
  }
}
