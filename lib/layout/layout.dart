import 'package:flutter/material.dart';

import 'package:close_up/pages/home.dart';
import 'package:close_up/pages/sentences.dart';
import 'package:close_up/pages/mypage.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      switch (index) {
        case 0:
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
          break;
        case 1:
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => SentencesPage()));
          break;
        case 2:
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
          break;
        case 3:
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyPage()));
          break;
      }
    }

    return Scaffold(
      body: Padding(padding: EdgeInsets.all(16), child: child),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              label: '홈',
              icon: Icon(Icons.home, size: 25, color: Colors.cyan.shade200)),
          BottomNavigationBarItem(
              label: '문장들',
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
        onTap: _onItemTapped,
      ),
    );
  }
}
