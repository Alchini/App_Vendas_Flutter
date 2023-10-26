import 'package:flutter/foundation.dart';

class UserBalance with ChangeNotifier {
  double _balance = 2.3;

  double get balance => _balance;

  void updateBalance(double newBalance) {
    _balance = newBalance;
    notifyListeners();
  }
}
