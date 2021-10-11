import 'package:develove/models/guild.dart';
import 'package:develove/models/message.dart';
import 'package:develove/services/supabase/constants.dart';
import 'package:develove/services/user.dart';

Future<bool> isMember(int gid, int uid) async {
  final res = await supabase
      .from('guilds')
      .select()
      .match({'gid': gid}).contains('mids', [uid]).execute();

  return (res.data as List<dynamic>).isEmpty;
}

Future<List<Guild>> fetchGuild() async {
  final user = await getUserInfo(supabase.auth.currentUser!.email!);
  final res = await supabase
      .from('guilds')
      .select()
      .contains('mids', [user!.uid]).execute();

  return (res.data as List<dynamic>).map((e) => Guild.fromJson(e)).toList();
}

Future<List<Message>> fetchMessages(int guildId) async {
  final res = await supabase
      .from('messages')
      .select()
      .filter('gid', 'eq', guildId)
      .order('mid', ascending: true)
      .execute();

  return (res.data as List<dynamic>).map((e) {
    print(e);
    return Message.fromJson(e);
  }).toList();
}

Future<void> createNewGuild(String guildName, List<String> tags) async {
  final user = await getUserInfo(supabase.auth.currentUser!.email!);
  final res = await supabase.from('guilds').insert({
    'mids': [user!.uid],
    'name': guildName,
    'uid': user.uid,
    'tags': tags,
  }).execute();
}

Future<void> sendMessage(int gid, String text) async {
  if (text.isNotEmpty) {
    final user = await getUserInfo(supabase.auth.currentUser!.email!);
    final res = await supabase.from('messages').insert({
      'gid': gid,
      'text': text,
      'uid': user!.uid,
      'created_at': DateTime.now().toString(),
    }).execute();
    print(res.status);
    print(res.status);
    print(res.status);
  }
}

Future<void> addMembersToGuild(int gid, int tid) async {
  final user = await getUserInfo(supabase.auth.currentUser!.email!);
  final res = await supabase.from('guilds').select().match({
    'uid': user!.uid,
    'gid': gid,
  }).execute();
  if ((res.data as List<dynamic>).isNotEmpty) {
    print((res.data as List<dynamic>)[0]);
    final guild = Guild.fromJson(res.data[0]);
    guild.mid.add(tid);
    final res2 = await supabase.from('guilds').upsert({
      'mids': guild.mid,
      'gid': gid,
    }).execute();
  } else {
    print('unsuccessful');
  }
  print(res.data);
}
