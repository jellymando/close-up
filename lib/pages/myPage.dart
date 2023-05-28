import 'package:flutter/material.dart';

import 'package:close_up/layout/layout.dart';
import 'package:close_up/utils/googleSignIn.dart';
import 'package:close_up/pages/login.dart';

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
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }

      await _myGoogleSignIn.signOut(onSuccess);
    }

    return MainLayout(
        child: Center(
      child: ElevatedButton(
        onPressed: handleSignOut,
        child: const Text('로그아웃'),
      ),
    ));
  }
}
