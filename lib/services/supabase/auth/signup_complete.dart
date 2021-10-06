import 'package:develove/services/supabase/constants.dart';

Future<void> updateUser(
    String fullName, List<String> tags, String? username) async {
  var data = {
    'username': username ?? await supabase.auth.currentUser!.email,
    'email': await supabase.auth.currentUser!.email,
    'fullName': fullName,
    'tags': tags,
  };
  final res = await supabase.from('users').insert(data).execute();
  print(res.status);
}

Future<dynamic> fetchUserData(String email) async {
  final res = await supabase
      .from('users')
      .select()
      .filter('email', 'eq', email)
      .execute();

  print(res.data);
  print(res.error);
  return res.data.length > 0 ? res.data[0] : null;
}
