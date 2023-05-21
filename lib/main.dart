import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

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
  GoogleSignInAccount? _account;
  bool _isLoggedIn = false; // has granted permissions?

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      // In mobile, being authenticated means being authorized...
      print(account);
      bool isAuthorized = account != null;
      setState(() {
        _account = account;
        _isLoggedIn = isAuthorized;
      });
    });

    _googleSignIn.signInSilently();
  }

  Widget build(BuildContext context) {
    return _isLoggedIn
        ? HomePage(googleSignIn: _googleSignIn, account: _account)
        : LoginPage(googleSignIn: _googleSignIn);
  }
}
