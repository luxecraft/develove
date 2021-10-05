class User {
  int uid;
  String? fullName;
  String email;
  String userName;

  User(
      {required this.uid,
      required this.email,
      required this.userName,
      this.fullName});
}
