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
      body: Center(
        child: ElevatedButton(
          onPressed: _handleSignOut,
          child: const Text('로그아웃'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              label: '홈',
              icon: Icon(Icons.home, size: 25, color: Colors.cyan.shade200)),
          BottomNavigationBarItem(
              label: '문장',
              icon: Icon(Icons.book, size: 22, color: Colors.cyan.shade200)),
          BottomNavigationBarItem(
              label: '한줄평',
              icon: Icon(Icons.featured_play_list,
                  size: 22, color: Colors.cyan.shade200)),
          BottomNavigationBarItem(
              label: '마이페이지',
              icon: Icon(Icons.account_circle,
                  size: 25, color: Colors.cyan.shade200))
        ],
      ),
    );
  }
}
