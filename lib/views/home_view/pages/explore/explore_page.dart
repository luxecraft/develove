import 'package:develove/models/user.dart';
import 'package:develove/services/supabase/connection.dart';
import 'package:develove/services/supabase/constants.dart';
import 'package:develove/services/typesense/search_users.dart';
import 'package:develove/views/home_view/pages/explore/connection_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text("Explore"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ConnectionView()));
                },
                icon: Icon(Icons.person_add_outlined)),
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearch(context));
              },
              icon: Icon(
                Icons.search,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomSearch extends SearchDelegate {
  BuildContext context;
  CustomSearch(this.context);

  @override
  TextInputAction get textInputAction => TextInputAction.done;

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
    return query != ""
        ? FutureBuilder(
            future: searchConnections(query),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //     colors: [Color(0xFF313131), Color(0xFF282828)],
                    //     begin: Alignment.topLeft,
                    //     end: Alignment.bottomRight),
                    color: Color(0xFF282828),
                  ),
                  child: snapshot.data != null
                      ? (() {
                          final data = snapshot.data as User;
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  data.fullName ?? "",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6,
                                                ),
                                                Text('@${data.userName}'),
                                              ],
                                            ),
                                            FutureBuilder(
                                                future: isConnected(data.uid),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData &&
                                                      supabase.auth.currentUser
                                                              ?.email !=
                                                          data.email &&
                                                      !(snapshot.data
                                                          as bool)) {
                                                    return OutlinedButton(
                                                      onPressed: () async {
                                                        await newConnection(
                                                            data.uid);
                                                      },
                                                      child: Text("Connect"),
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }())
                      : Container(
                          decoration: BoxDecoration(
                            // gradient: LinearGradient(
                            //     colors: [Color(0xFF313131), Color(0xFF282828)],
                            //     begin: Alignment.topLeft,
                            //     end: Alignment.bottomRight),
                            color: Color(0xFF282828),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No results Found",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                );
              } else {
                return Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF282828),

                    // gradient: LinearGradient(
                    //     colors: [Color(0xFF313131), Color(0xFF282828)],
                    //     begin: Alignment.topLeft,
                    //     end: Alignment.bottomRight),
                  ),
                );
              }
            })
        : Container(
            decoration: BoxDecoration(
              color: Color(0xFF282828),

              // gradient: LinearGradient(
              //     colors: [Color(0xFF313131), Color(0xFF282828)],
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight),
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF282828),
      ),
      child: FutureBuilder(
          future: searchConnections(query),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final results = (snapshot.data as Map<String, dynamic>)['hits']
                  .map((e) => User.fromJson(e['document']))
                  .toList();
              return ListView.builder(
                  itemCount: 2,
                  itemBuilder: (_, position) {
                    final data = results[position];
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(
                                  width: 1.0, color: Color(0xFF6ECD95))),
                          child: Row(children: [
                            Expanded(
                              child: SizedBox(
                                height: 80,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
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
                                              );
                                            } else {
                                              return Container(
                                                height: 70,
                                                width: 70,
                                              );
                                            }
                                          }),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            data.fullName ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
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
                                                supabase.auth.currentUser
                                                        ?.email !=
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
                                  ),
                                ),
                              ),
                            ),
                          ]),
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
          }),
    );
  }
}
