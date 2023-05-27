import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:close_up/model/account.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.googleSignIn, required this.account})
      : super(key: key);

  final GoogleSignIn googleSignIn;
  final Account account;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();

    _checkAccount(widget.account);
  }

  final db = FirebaseFirestore.instance;

  Future<void> _handleSignOut() async {
    await widget.googleSignIn.disconnect();
  }

  Future<bool> _getIsExistAccount(id) async {
    QuerySnapshot querySnapshot =
        await db.collection('users').where('id', isEqualTo: id).limit(1).get();
    print('isUserExist');
    print(querySnapshot.docs.isNotEmpty);
    return querySnapshot.docs.isNotEmpty;
  }

  void showAlertDialog(BuildContext context, String? nickname) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
              '반갑습니다 ${nickname != null ? nickname + '님!' : ''}\n클로즈업에 가입되었습니다.',
              textAlign: TextAlign.center),
          actions: <Widget>[
            TextButton(
              child: Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _createAccount(Account account) async {
    Map<String, dynamic> accountData = {
      'id': account.id,
      'email': account.email,
      'nickname': account.nickname,
      'profileImageUrl': account.profileImageUrl,
    };
    await db.collection("users").add(accountData);
    showAlertDialog(context, account.nickname);
  }

  Future<void> _checkAccount(Account account) async {
    bool isExistAcconut = await _getIsExistAccount(account.id);
    if (!isExistAcconut) {
      await _createAccount(account);
    }
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
