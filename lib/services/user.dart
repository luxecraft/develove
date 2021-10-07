import 'package:develove/models/user.dart';
import 'package:develove/services/supabase/constants.dart';
import 'package:develove/services/supabase/auth/signup_complete.dart';

Future<User?> getUserInfo(String email) async {
  final data = await fetchUserData(email);
  return User.fromJson(data);
}

Future<User?> getUserInfoById(int id) async {
  final res =
      await supabase.from('users').select().filter('uid', 'eq', id).execute();
  final data = res.data[0];
  return User.fromJson(data);
}

Future<bool> isUserPresent(String email) async {
  if (await fetchUserData(email) == null) {
    return false;
  }
  return true;
}
