import 'package:develove/models/guild.dart';
import 'package:develove/models/message.dart';
import 'package:develove/services/guilds.dart';
import 'package:develove/services/supabase/constants.dart';
import 'package:develove/views/home_view/pages/guilds/guild_expanded.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GuildListPage extends StatelessWidget {
  GuildListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchGuild(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final data = snapshot.data as List<Guild>;
            return ChangeNotifierProvider(
                create: (_) => GuildModel(guilds: data),
                builder: (context, _) {
                  return Column(children: [
                    AppBar(
                      title: Text("Guilds"),
                      actions: [
                        IconButton(
                          icon: Icon(Icons.sync),
                          onPressed: () async {
                            await Provider.of<GuildModel>(context,
                                    listen: false)
                                .updateGuilds();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (_) => NewGuildDialog());
                            await Provider.of<GuildModel>(context,
                                    listen: false)
                                .updateGuilds();
                          },
                        ),
                      ],
                    ),
                    ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            Provider.of<GuildModel>(context).guilds.length,
                        itemBuilder: (_, position) {
                          final guild =
                              Provider.of<GuildModel>(context).guilds[position];
                          return ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => FutureBuilder(
                                          future: fetchMessages(guild.gid),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                    ConnectionState.done &&
                                                snapshot.hasData) {
                                              final messages = snapshot.data
                                                  as List<Message>;

                                              return ChangeNotifierProvider(
                                                  create: (_) => MessageModel(
                                                      guildId: guild.gid,
                                                      messages: messages),
                                                  builder: (context, _) {
                                                    return GuildExpandedView(
                                                      guild: guild,
                                                      context: context,
                                                    );
                                                  });
                                            } else {
                                              return SafeArea(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CircularProgressIndicator(),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          })));
                            },
                            title: Text(guild.name),
                            trailing: Icon(Icons.arrow_forward_ios),
                          );
                        })
                  ]);
                });
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator()],
            );
          }
        });
  }
}

class NewGuildDialog extends StatelessWidget {
  final _guildNameController = TextEditingController();
  final _tagController = TextEditingController();
  NewGuildDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Text("New Guild"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Guild Name"),
          SizedBox(height: 5),
          TextField(
            controller: _guildNameController,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              focusColor: Colors.transparent,
              fillColor: Color(0xFF313131),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _tagController,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              focusColor: Colors.transparent,
              fillColor: Color(0xFF313131),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel")),
        TextButton(
            onPressed: () async {
              await createNewGuild(
                  _guildNameController.text, [_tagController.text]);
              Navigator.pop(context);
            },
            child: Text("Ok")),
      ],
    );
  }
}
