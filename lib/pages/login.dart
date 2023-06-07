import 'package:flutter/material.dart';

import 'package:close_up/utils/googleSignIn.dart';
import 'package:close_up/widgets/button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final MyGoogleSignIn _myGoogleSignIn = MyGoogleSignIn.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/close_up_gradient.png", width: 180),
          SizedBox(height: 150),
          SizedBox(
            width: 220,
            height: 40,
            child: Button(
                onPressed: _myGoogleSignIn.signIn,
                isFill: false,
                type: 'secondary',
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset("assets/images/google_logo.png",
                      width: 20, height: 20),
                  SizedBox(width: 20),
                  Text('Google로 시작하기', style: TextStyle(color: Colors.black87)),
                ])),
          ),
        ],
      ),
    );
  }
}
