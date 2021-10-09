import 'package:develove/models/user.dart';
import 'package:develove/services/supabase/connection.dart';
import 'package:develove/services/supabase/constants.dart';
import 'package:develove/services/typesense/search_users.dart';
import 'package:develove/views/home_view/explore/connection_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class NewExplorePage extends StatelessWidget {
  const NewExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (_, __) => [
                SliverAppBar(
                  pinned: true,
                  title: Text("Explore"),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ConnectionView()));
                        },
                        icon: Icon(Icons.person_add_outlined)),
                    IconButton(
                      onPressed: () {
                        showSearch(
                            context: context, delegate: CustomSearch(context));
                      },
                      icon: Icon(
                        Icons.search,
                      ),
                    ),
                  ],
                ),
              ],
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FutureBuilder(
              future: searchConnections(''),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  final results =
                      (snapshot.data as Map<String, dynamic>)['hits']
                          .map((e) => User.fromJson(e['document']))
                          .toList();
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: results.length,
                      itemBuilder: (_, position) {
                        final data = results[position];
                        return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05,
                                vertical: 4.0),
                            child: SizedBox(
                              height: 80,
                              child: ListTile(
                                tileColor: Color(0xFF474747),
                                contentPadding: EdgeInsets.all(8.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  // side: BorderSide(
                                  //     width: 1.0, color: Color(0xFF6ECD95)),
                                ),
                                leading: FutureBuilder(
                                    future: http.get(Uri.parse(
                                        "https://avatars.dicebear.com/api/miniavs/${data.userName}.svg")),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          snapshot.hasData) {
                                        return SvgPicture.string(
                                          (snapshot.data as http.Response)
                                              .body
                                              .toString(),
                                          height: 70,
                                          width: 70,
                                        );
                                      } else {
                                        return SizedBox(
                                          height: 70,
                                          width: 70,
                                        );
                                      }
                                    }),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      data.fullName ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    Text(
                                      '@${data.userName}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                trailing: FutureBuilder(
                                    future: isConnected(data.uid),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          supabase.auth.currentUser?.email !=
                                              data.email &&
                                          !(snapshot.data as bool)) {
                                        return OutlinedButton(
                                          onPressed: () async {
                                            await newConnection(data.uid);
                                          },
                                          child: Text("Connect"),
                                        );
                                      } else {
                                        return SizedBox();
                                      }
                                    }),
                              ),
                            ));
                      });
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      )
                    ],
                  );
                }
              },
            ),
          )),
    );
  }
}

class CustomSearch extends SearchDelegate {
  BuildContext context;
  CustomSearch(this.context);

  @override
  TextInputAction get textInputAction => TextInputAction.none;

  @override
  InputDecorationTheme? get searchFieldDecorationTheme => InputDecorationTheme(
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(width: 1, color: Colors.grey)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(width: 1, color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(width: 1, color: Colors.grey)),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 4.0,
        ),
      );
  @override
  TextStyle? get searchFieldStyle => TextStyle(fontSize: 10.0);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FutureBuilder(
        future: searchConnections(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final results = (snapshot.data as Map<String, dynamic>)['hits']
                .map((e) => User.fromJson(e['document']))
                .toList();
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: results.length,
                itemBuilder: (_, position) {
                  final data = results[position];
                  return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                          vertical: 4.0),
                      child: SizedBox(
                        height: 80,
                        child: ListTile(
                          tileColor: Color(0xFF474747),
                          contentPadding: EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            // side: BorderSide(
                            //     width: 1.0, color: Color(0xFF6ECD95)),
                          ),
                          leading: FutureBuilder(
                              future: http.get(Uri.parse(
                                  "https://avatars.dicebear.com/api/miniavs/${data.userName}.svg")),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  return SvgPicture.string(
                                    (snapshot.data as http.Response)
                                        .body
                                        .toString(),
                                    height: 70,
                                    width: 70,
                                  );
                                } else {
                                  return SizedBox(
                                    height: 70,
                                    width: 70,
                                  );
                                }
                              }),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                data.fullName ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                '@${data.userName}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          trailing: FutureBuilder(
                              future: isConnected(data.uid),
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    supabase.auth.currentUser?.email !=
                                        data.email &&
                                    !(snapshot.data as bool)) {
                                  return OutlinedButton(
                                    onPressed: () async {
                                      await newConnection(data.uid);
                                    },
                                    child: Text("Connect"),
                                  );
                                } else {
                                  return SizedBox();
                                }
                              }),
                        ),
                      ));
                });
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }
}
