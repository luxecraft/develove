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
              itemBuilder: (_, __) => SizedBox(
                height: 200,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.grey))),
                  padding: EdgeInsets.all(16.0),
                  child: Text("Placeholder"),
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
