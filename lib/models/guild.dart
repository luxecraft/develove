import 'package:develove/services/guilds.dart';
import 'package:flutter/foundation.dart';

class Guild {
  late String name;
  late int gid;
  late int uid;
  late List<int> mid;

  Guild(
      {required this.name,
      required this.gid,
      required this.uid,
      required this.mid});

  Guild.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    gid = json['gid'];
    mid =
        List<int>.from((json['mids'] as List<dynamic>).map((e) => e).toList());
  }
}

class GuildModel extends ChangeNotifier {
  List<Guild> guilds = [];

  GuildModel({required this.guilds});

  Future<void> updateGuilds() async {
    guilds = await fetchGuild();
    notifyListeners();
  }
}
