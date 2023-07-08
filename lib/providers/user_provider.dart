
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  //update the value of the user
  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails(); // this user variable contains currentUser info. after refreshing data
    _user = user;
    notifyListeners();
  }
}