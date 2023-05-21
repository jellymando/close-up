import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.googleSignIn, required this.account})
      : super(key: key);

  final GoogleSignIn googleSignIn;
  final GoogleSignInAccount? account;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _handleSignOut() async {
    await widget.googleSignIn.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('클로즈업'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _handleSignOut,
          child: const Text('로그아웃'),
        ),
      ),
    );
  }
}
