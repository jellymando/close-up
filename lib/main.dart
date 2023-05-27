import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

import 'model/account.dart';
import 'screens/home.dart';
import 'screens/login.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
    // clientId: '',
    );

void main() {
  runApp(
    const MaterialApp(
      home: App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Account? _account;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    Firebase.initializeApp();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? googleAccount) async {
      print(googleAccount);
      bool isAuthorized = googleAccount != null;

      setState(() {
        _account = Account(
          id: googleAccount?.id ?? '',
          email: googleAccount?.email ?? '',
          nickname: googleAccount?.displayName ?? '',
          profileImageUrl: googleAccount?.photoUrl ?? '',
        );
        _isLoggedIn = isAuthorized;
      });
    });

    _googleSignIn.signInSilently();
  }

  Widget build(BuildContext context) {
    return _isLoggedIn
        ? HomePage(googleSignIn: _googleSignIn, account: _account!)
        : LoginPage(googleSignIn: _googleSignIn);
  }
}
