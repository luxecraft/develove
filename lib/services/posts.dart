import 'package:develove/models/post.dart';
import 'package:develove/services/constants.dart';

class PostServices {
  static Future<List<Post>> getPosts() async {
    List<Post> posts = [];
    final res = await supabase.from('posts').select().execute();
    print(res.status);
    for (int i = 0; i < res.data.length; i++) {
      final data = res.data[i];
      posts.add(Post(
          pid: data['pid'],
          uid: data['uid'],
          title: data['title'],
          content: data['data'],
          hearts: data['hearts'],
          tags: (data['tags'] as List<dynamic>)
              .map((e) => e.toString())
              .toList()));
    }
    return posts;
  }
}

printPosts() async {
  print(await PostServices.getPosts());
}
