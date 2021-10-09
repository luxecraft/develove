import 'package:develove/models/guild.dart';
import 'package:develove/models/user.dart';
import 'package:develove/services/dicebear.dart';
import 'package:develove/services/guilds.dart';
import 'package:develove/services/supabase/constants.dart';
import 'package:develove/services/typesense/search_users.dart';
import 'package:develove/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class GuildInfoView extends StatelessWidget {
  final Guild guild;
  const GuildInfoView({Key? key, required this.guild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        FutureBuilder(
            future: getUserInfo(supabase.auth.currentUser!.email!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  (snapshot.data as User).uid == guild.uid) {
                return IconButton(
                    onPressed: () async {
                      await showSearch(
                          context: context,
                          delegate:
                              CustomSearch(context: context, gid: guild.gid));
                      Provider.of<GuildModel>(context, listen: false)
                          .updateGuilds();
                    },
                    icon: Icon(Icons.group_add_outlined));
              } else {
                return Container();
              }
            }),
      ]),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.2,
                          backgroundColor: Color(0xFF6ECD95),
                          child: FutureBuilder(
                              future: DicebearServices.getAvatar(
                                  AvatarType.bottts, guild.gid.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  print(snapshot.data.toString());
                                  return SvgPicture.string(
                                    snapshot.data.toString(),
                                    height:
                                        MediaQuery.of(context).size.width * 0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                  );
                                } else {
                                  return SizedBox(
                                    height:
                                        MediaQuery.of(context).size.width * 0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                  );
                                }
                              }),
                        ),
                        SizedBox(height: 20),
                        Text(
                          guild.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.apply(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Members",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 10),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: guild.mid.length,
                  itemBuilder: (_, position) {
                    return FutureBuilder(
                        future: getUserInfoById(guild.mid[position]),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            final data = snapshot.data as User;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 80,
                                child: ListTile(
                                  tileColor: Color(0xFF474747),
                                  contentPadding: EdgeInsets.all(8.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    // side: BorderSide(
                                    //     width: 1.0,
                                    //     color: Color(0xFF6ECD95)),
                                  ),
                                  onTap: () {},
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
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        });
                  })
            ],
          ),
        ),
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
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
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
                          // side:
                          //     BorderSide(width: 1.0, color: Color(0xFF6ECD95)),
                        ),
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
                                                width: 70,
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
