import 'package:flutter/material.dart';
import 'package:my_app/data/repository.dart';
import 'package:my_app/utils/status.dart';

class LoginChangeNotifier extends ChangeNotifier {
  final Repository _repository;
  Status status = Status.loaded;
  String? passwordError;

  LoginChangeNotifier(this._repository);

  Future<void> loginUser(String email, String password) async {
    status = Status.loading;
    notifyListeners();
    final isValidateUser = await _repository.validateUser(email, password);
    status = isValidateUser ? Status.success : Status.error;
    notifyListeners();
    status = Status.loaded;
  }

  void validatePassword(String? password) {
    if (password == null) {
      passwordError = null;
    } else if (password.isEmpty) {
      passwordError = 'Password is required';
    } else {
      passwordError = null;
    }

    notifyListeners();
  }
}
