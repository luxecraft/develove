import 'package:develove/models/post.dart';
import 'package:develove/services/supabase/constants.dart';

class PostServices {
  static Future<List<Post>> getPosts() async {
    List<Post> posts = [];
    final res = await supabase.from('posts').select().execute();
    print(res.status);
    for (int i = 0; i < res.data.length; i++) {
      final data = res.data[i];
      posts.add(Post.fromJson(data));
    }
    return posts;
  }
}

printPosts() async {
  print(await PostServices.getPosts());
}
