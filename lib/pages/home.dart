import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:close_up/provider/provider.dart';
import 'package:close_up/layout/main.dart';
import 'package:close_up/model/account.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final myState = Provider.of<MyState>(context, listen: false);

      _checkAccount(myState.account);
    });
  }

  Future<bool> _getIsExistAccount(id) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .limit(1)
        .get();
    print('isUserExist');
    print(querySnapshot.docs.isNotEmpty);
    return querySnapshot.docs.isNotEmpty;
  }

  void _showAlertDialog(BuildContext context, String? nickname) {
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
    await FirebaseFirestore.instance.collection("users").add(accountData);
    _showAlertDialog(context, account.nickname);
  }

  Future<void> _checkAccount(Account account) async {
    bool isExistAcconut = await _getIsExistAccount(account.id);
    if (!isExistAcconut) {
      await _createAccount(account);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(child: Center(child: Text('안녕하세요?')));
  }
}
