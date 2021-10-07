import 'package:develove/models/user.dart';
import 'package:develove/services/supabase/connection.dart';
import 'package:develove/services/supabase/constants.dart';
import 'package:develove/services/user.dart';
import 'package:develove/views/home_view/pages/explore/connection_view.dart';
import 'package:flutter/material.dart';

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
            future: getUserInfo(query),
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

        // gradient: LinearGradient(
        //     colors: [Color(0xFF313131), Color(0xFF282828)],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight),
      ),
    );
  }
}
