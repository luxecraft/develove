import 'package:develove/models/guild.dart';
import 'package:develove/models/user.dart';
import 'package:develove/services/guilds.dart';
import 'package:develove/services/supabase/constants.dart';
import 'package:develove/services/typesense/search_users.dart';
import 'package:develove/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class GuildInfoView extends StatelessWidget {
  final Guild guild;
  const GuildInfoView({Key? key, required this.guild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //     colors: [Color(0xFF313131), Color(0xFF282828)],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight),
        color: Color(0xFF282828),
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
                        final data = snapshot.data as User;
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                        width: 1.0, color: Color(0xFF6ECD95))),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 100,
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListTile(
                                              leading: FutureBuilder(
                                                  future: http.get(Uri.parse(
                                                      "https://avatars.dicebear.com/api/miniavs/${data.userName}.svg")),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.connectionState ==
                                                            ConnectionState
                                                                .done &&
                                                        snapshot.hasData) {
                                                      return SvgPicture.string(
                                                        (snapshot.data as http
                                                                .Response)
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6,
                                                  ),
                                                  Text(
                                                    '@${data.userName}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )));
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
  TextInputAction get textInputAction => TextInputAction.none;

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
      color: Color(0xFF282828),

      // gradient: LinearGradient(
      //     colors: [Color(0xFF313131), Color(0xFF282828)],
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: searchConnections(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final results = (snapshot.data as Map<String, dynamic>)['hits']
                .map((e) => User.fromJson(e['document']))
                .toList();
            return Container(
              color: Color(0xFF282828),
              child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, position) {
                    final data = results[position];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                                width: 1.0, color: Color(0xFF6ECD95))),
                        child: Row(
                          children: [
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
                                              return SizedBox();
                                            }
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return Container(
              color: Color(0xFF282828),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  )
                ],
              ),
            );
          }
        });
  }
}
