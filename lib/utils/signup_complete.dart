import 'package:develove/utils/constants.dart';

Future<void> updateUser(String fullName, List<String> tags, String? username) async {
  var data = {
    'username': username ?? await supabase.auth.currentUser!.email,
    'email': await supabase.auth.currentUser!.email,
    'fullName': fullName,
    'tags': tags,
  };
  final res = await supabase.from('users').insert(data).execute();
  print(res.status);
  print(res.error);
}