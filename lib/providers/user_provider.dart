// filepath: c:\Users\paul1\Desktop\Aplicatie finala\Apk flutter\my_money_flow\lib\providers\user_provider.dart
import 'package:flutter/material.dart';
import 'package:my_money_flow/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}