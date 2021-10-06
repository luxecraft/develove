import 'package:develove/models/guild.dart';
import 'package:develove/models/user.dart';
import 'package:develove/services/guilds.dart';
import 'package:develove/services/supabase/constants.dart';
import 'package:develove/services/user.dart';
import 'package:flutter/material.dart';

class GuildInfoView extends StatelessWidget {
  final Guild guild;
  const GuildInfoView({Key? key, required this.guild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF313131), Color(0xFF282828)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Column(
        children: [
          AppBar(actions: [
            FutureBuilder(
                future: getUserInfo(supabase.auth.currentUser!.email!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData &&
                      (snapshot.data as User).uid == guild.uid) {
                    return IconButton(
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: CustomSearch(
                                  context: context, gid: guild.gid));
                        },
                        icon: Icon(Icons.group_add_outlined));
                  } else {
                    return Container();
                  }
                }),
          ]),
          ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: guild.mid.length,
              itemBuilder: (_, position) {
                return FutureBuilder(
                    future: getUserInfoById(guild.mid[position]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        final user = snapshot.data as User;
                        return Row(
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
                                            user.fullName ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          Text('@${user.userName}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    });
              })
        ],
      ),
    );
  }
}

class CustomSearch extends SearchDelegate {
  BuildContext context;
  int gid;
  CustomSearch({required this.context, required this.gid});

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
                    gradient: LinearGradient(
                        colors: [Color(0xFF313131), Color(0xFF282828)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
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
                                                future: isMember(gid, data.uid),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData &&
                                                      supabase.auth.currentUser
                                                              ?.email !=
                                                          data.email &&
                                                      (snapshot.data as bool)) {
                                                    return OutlinedButton(
                                                      onPressed: () async {
                                                        await addMembersToGuild(
                                                            gid, data.uid);
                                                      },
                                                      child: Text("Add"),
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
                            gradient: LinearGradient(
                                colors: [Color(0xFF313131), Color(0xFF282828)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
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
                    gradient: LinearGradient(
                        colors: [Color(0xFF313131), Color(0xFF282828)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                  ),
                );
              }
            })
        : Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF313131), Color(0xFF282828)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF313131), Color(0xFF282828)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
    );
  }
}
