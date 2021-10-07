import 'package:develove/models/post.dart';
import 'package:develove/services/supabase/posts.dart';
import 'package:develove/views/post_expanded.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String? userId;
  const HomePage({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PostServices.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final posts = snapshot.data as List<Post>;
            return ChangeNotifierProvider(
                create: (_) => PostModel(posts),
                builder: (context, _) {
                  return Stack(
                    children: [
                      NestedScrollView(
                        physics: BouncingScrollPhysics(),
                        headerSliverBuilder: (context, isScrolled) => [
                          SliverAppBar(
                            elevation: 1.0,
                            systemOverlayStyle: SystemUiOverlayStyle(
                                statusBarColor:
                                    Color(0xFF313131).withOpacity(0.9)),
                            backgroundColor: Color(0xFF313131).withOpacity(0.9),
                            pinned: true,
                            centerTitle: true,
                            title: Image.asset(
                              'assets/images/HeartMap.png',
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ],
                        body: RefreshIndicator(
                          onRefresh: () async {
                            await Provider.of<PostModel>(context, listen: false)
                                .fetchPosts();
                          },
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  Provider.of<PostModel>(context).posts.length,
                              itemBuilder: (_, position) {
                                final post = Provider.of<PostModel>(context)
                                    .posts[position];
                                return SizedBox(
                                  // height: 200,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1.0,
                                                color: Colors.grey))),
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PostExpandedView(
                                                            post)));
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                post.title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                              ),
                                              SizedBox(height: 10),
                                              Markdown(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets.zero,
                                                data: post.content,
                                                shrinkWrap: true,
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                                padding: EdgeInsets.zero,
                                                splashRadius: 15,
                                                iconSize: 20,
                                                onPressed: () {},
                                                icon: Row(
                                                  children: [
                                                    Icon(Icons.favorite_border),
                                                    SizedBox(width: 2),
                                                    Text(
                                                        post.hearts.toString()),
                                                  ],
                                                )),
                                            IconButton(
                                                padding: EdgeInsets.zero,
                                                splashRadius: 15,
                                                iconSize: 20,
                                                onPressed: () {},
                                                icon: Icon(
                                                    Icons.chat_bubble_outline)),
                                            IconButton(
                                                padding: EdgeInsets.zero,
                                                splashRadius: 15,
                                                iconSize: 20,
                                                onPressed: () {},
                                                icon: Icon(
                                                    Icons.keyboard_arrow_up)),
                                            IconButton(
                                              padding: EdgeInsets.zero,
                                              splashRadius: 15,
                                              iconSize: 20,
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FloatingActionButton(
                            onPressed: () {},
                            child: Icon(Icons.add),
                          ),
                        ),
                      )
                    ],
                  );
                });
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
              ],
            );
          }
        });
  }
}
