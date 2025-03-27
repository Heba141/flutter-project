// user.dart
import 'dart:io';

import 'package:flutter/cupertino.dart';
class UserNotifier with ChangeNotifier {
  User user = User(name: 'heba_sbateen', email: 'hebasbateen7@gmail.com', phone: '1234567890',password:'1234');

  void setUser(User user) {
    this.user = user;
    notifyListeners();
  }
}


class User {
  String name;
  String email;
  String phone;
  File? profileImage;// Add this field to store the profile image
  String password;

  User(
      {required this.name, required this.email, required this.phone, this.profileImage,required this.password});
}