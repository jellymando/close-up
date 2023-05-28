import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:close_up/provider/provider.dart';
import 'package:close_up/utils/googleSignIn.dart';
import 'package:close_up/model/account.dart';
import 'package:close_up/pages/home.dart';
import 'package:close_up/pages/login.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (_) => MyState(),
        child: MaterialApp(
          home: App(),
        )),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final MyGoogleSignIn _myGoogleSignIn = MyGoogleSignIn.instance;
  StreamSubscription<GoogleSignInAccount?>? _userChangedSubscription;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    Firebase.initializeApp();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final myState = Provider.of<MyState>(context, listen: false);

      _userChangedSubscription = _myGoogleSignIn.onCurrentUserChanged
          .listen((GoogleSignInAccount? googleAccount) async {
        print('googleAccount');
        print(googleAccount);
        bool isAuthorized = googleAccount != null;

        myState.setAccount(Account(
          id: googleAccount?.id ?? '',
          email: googleAccount?.email ?? '',
          nickname: googleAccount?.displayName ?? '',
          profileImageUrl: googleAccount?.photoUrl ?? '',
        ));
        setState(() {
          _isLoggedIn = isAuthorized;
        });
      });
    });
  }

  @override
  void dispose() {
    _userChangedSubscription?.cancel();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return _isLoggedIn ? HomePage() : LoginPage();
  }
}
