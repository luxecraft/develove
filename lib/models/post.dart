import 'package:develove/services/posts.dart';
import 'package:flutter/foundation.dart';

class Post {
  int pid;
  int uid;
  int hearts;
  String title;
  String content;
  List<String> tags;

  Post(
      {required this.pid,
      required this.uid,
      required this.title,
      required this.content,
      required this.hearts,
      required this.tags});
}

class PostModel extends ChangeNotifier {
  List<Post> posts = [];

  PostModel(this.posts);

  fetchPosts() async {
    posts = await PostServices.getPosts();
    notifyListeners();
  }
}
