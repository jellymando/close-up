import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.googleSignIn}) : super(key: key);

  final GoogleSignIn googleSignIn;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _handleSignIn() async {
    try {
      await widget.googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.cyan.shade300,
            Colors.blue.shade200,
            Colors.deepPurple.shade100
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/close_up.png", width: 250),
          SizedBox(height: 100),
          SizedBox(
            width: 230,
            child: ElevatedButton(
                onPressed: _handleSignIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset("assets/images/google_logo.png",
                      width: 24, height: 24),
                  SizedBox(width: 24),
                  Text('Google로 시작하기', style: TextStyle(color: Colors.black87)),
                ])),
          ),
        ],
      ),
    );
  }
}
