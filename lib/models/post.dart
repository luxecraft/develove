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
