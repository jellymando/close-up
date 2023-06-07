import 'package:flutter/material.dart';

import 'package:close_up/utils/googleSignIn.dart';
import 'package:close_up/main.dart';
import 'package:close_up/layout/main.dart';
import 'package:close_up/widgets/button.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final MyGoogleSignIn _myGoogleSignIn = MyGoogleSignIn.instance;

  @override
  Widget build(BuildContext context) {
    Future<void> handleSignOut() async {
      void onSuccess() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => App()));
      }

      await _myGoogleSignIn.signOut(onSuccess);
    }

    return MainLayout(
        child: Center(
      child: Button(
        onPressed: handleSignOut,
        child: const Text('로그아웃'),
      ),
    ));
  }
}
