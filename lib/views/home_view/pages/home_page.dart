import 'package:develove/views/post_expanded.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  final String? userId;
  const HomePage({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (context, isScrolled) => [
            SliverAppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color(0xFF313131).withOpacity(0.9)),
              backgroundColor: Color(0xFF313131).withOpacity(0.9),
              pinned: true,
              centerTitle: true,
              title: Image.asset(
                'assets/images/HeartMap.png',
                height: 30,
                width: 30,
              ),
              // // elevation: 5.0,
              // expandedHeight: MediaQuery.of(context).size.height * 0.2,
              // flexibleSpace: FlexibleSpaceBar(
              //   titlePadding: EdgeInsets.symmetric(
              //       horizontal: MediaQuery.of(context).size.width * 0.05),
              //   title: Text(
              //     userId != null ? 'Welcome' : 'No user',
              //     style: TextStyle(
              //       // fontSize: 30,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ),
          ],
          body: RefreshIndicator(
            onRefresh: () async {},
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (_, __) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PostExpandedView(title: "Placeholder")));
                },
                child: SizedBox(
                  height: 200,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1.0, color: Colors.grey))),
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Placeholder"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                padding: EdgeInsets.zero,
                                splashRadius: 0.1,
                                iconSize: 20,
                                onPressed: () {},
                                icon: Icon(Icons.favorite_border)),
                            IconButton(
                                padding: EdgeInsets.zero,
                                splashRadius: 0.1,
                                iconSize: 20,
                                onPressed: () {},
                                icon: Icon(Icons.chat_bubble_outline)),
                            IconButton(
                                padding: EdgeInsets.zero,
                                splashRadius: 0.1,
                                iconSize: 20,
                                onPressed: () {},
                                icon: Icon(Icons.keyboard_arrow_up)),
                            IconButton(
                              padding: EdgeInsets.zero,
                              splashRadius: 0.1,
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
              ),
            ),
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
  }
}
