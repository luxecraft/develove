import 'package:flutter/foundation.dart';

class User {
  late int uid;
  late String? fullName;
  late String email;
  late String userName;
  late List<String> tags;
  late String avatarUrl;

  User(
      {required this.uid,
      required this.email,
      required this.userName,
      required this.tags,
      this.fullName}) {
    avatarUrl = "https://avatars.dicebear.com/api/miniavs/${userName}.svg";
  }

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    uid = json['uid'];
    userName = json['username'];
    fullName = json['fullName'];
    tags = (json['tags'] as List<dynamic>).map((e) => e.toString()).toList();
    avatarUrl = "https://avatars.dicebear.com/api/miniavs/${userName}.svg";
  }
}

class UserModel extends ChangeNotifier {}
