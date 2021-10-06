import 'package:develove/services/supabase/posts.dart';
import 'package:flutter/foundation.dart';

class Post {
  late int pid;
  late int uid;
  late int hearts;
  late String title;
  late String content;
  late List<String> tags;

  Post(
      {required this.pid,
      required this.uid,
      required this.title,
      required this.content,
      required this.hearts,
      required this.tags});

  Post.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    uid = json['uid'];
    title = json['title'];
    content = json['data'];
    hearts = json['hearts'];
    tags = (json['tags'] as List<dynamic>).map((e) => e.toString()).toList();
  }
}

class PostModel extends ChangeNotifier {
  List<Post> posts = [];

  PostModel(this.posts);

  fetchPosts() async {
    posts = await PostServices.getPosts();
    notifyListeners();
  }
}
