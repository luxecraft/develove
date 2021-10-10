import 'package:develove/services/guilds.dart';
import 'package:flutter/material.dart';

class Message {
  late int mid;
  late String text;
  late DateTime createdAt;
  late int gid;
  late int uid;

  Message({
    required this.mid,
    required this.gid,
    required String createdAt,
    required this.text,
    required this.uid,
  }) {
    this.createdAt = DateTime.tryParse(createdAt)!;
  }

  Message.fromJson(Map<String, dynamic> json) {
    mid = json['mid'];
    text = json['text'];
    createdAt = DateTime.tryParse(json['created_at'])!;
    gid = json['gid'];
    uid = json['uid'];
  }
}

class MessageModel extends ChangeNotifier {
  final int guildId;
  List<Message> messages = [];

  MessageModel({required this.guildId, required this.messages});

  Future<void> updateMessages() async {
    messages = await fetchMessages(guildId);
    notifyListeners();
  }

  fetchChanges(Map<String, dynamic> data) {
    messages.add(Message.fromJson(data));
    notifyListeners();
  }
}
