import 'package:flutter/material.dart';

import 'package:close_up/model/account.dart';

class MyState with ChangeNotifier {
  Account _account = Account(
    id: '',
    email: '',
    nickname: '',
    profileImageUrl: '',
  );

  Account get account => _account;

  void setAccount(Account account) {
    _account = account;
    notifyListeners();
  }
}
