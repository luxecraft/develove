import 'package:develove/models/post.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_highlight/flutter_highlight.dart';
// import 'package:flutter_highlight/themes/atom-one-dark-reasonable.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PostExpandedView extends StatelessWidget {
  final Post post;
  const PostExpandedView(this.post, {Key? key}) : super(key: key);

  final code = """# Python program to demonstrate working
# of map.
  
# Return double of n
def addition(n):
    return n + n
  
# We double all numbers using map()
numbers = (1, 2, 3, 4)
result = map(addition, numbers)
print(list(result))""";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF282828),

        // gradient: LinearGradient(
        //     colors: [Color(0xFF313131), Color(0xFF282828)],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.grey))),
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 10),
                      Markdown(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        data: post.content,
                        shrinkWrap: true,
                      ),
                      // Text(
                      //   post.content,
                      // ),
                      SizedBox(height: 10),
                      // Card(
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(15.0),
                      //   ),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(15.0),
                      //     child: HighlightView(
                      //       code,
                      //       padding: EdgeInsets.all(8.0),
                      //       tabSize: 4,
                      //       language: 'python',
                      //       theme: atomOneDarkReasonableTheme,
                      //     ),
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  Text(post.hearts.toString()),
                                ],
                              )),
                          IconButton(
                              padding: EdgeInsets.zero,
                              splashRadius: 15,
                              iconSize: 20,
                              onPressed: () {},
                              icon: Icon(Icons.chat_bubble_outline)),
                          IconButton(
                              padding: EdgeInsets.zero,
                              splashRadius: 15,
                              iconSize: 20,
                              onPressed: () {},
                              icon: Icon(Icons.keyboard_arrow_up)),
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
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
