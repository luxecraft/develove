import 'package:develove/models/guild.dart';
import 'package:develove/models/message.dart';
import 'package:develove/services/dicebear.dart';
import 'package:develove/services/guilds.dart';
import 'package:develove/views/home_view/guilds/guild_expanded_view.dart';
import 'package:develove/views/home_view/guilds/new_guild_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                  return NestedScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    headerSliverBuilder: (_, __) => [
                      SliverAppBar(
                        pinned: true,
                        title: Text("Guilds"),
                        actions: [
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          ChangeNotifierProvider.value(
                                              value: Provider.of<GuildModel>(
                                                  context),
                                              builder: (context, _) {
                                                return NewGuildView();
                                              })));
                              await Provider.of<GuildModel>(context,
                                      listen: false)
                                  .updateGuilds();
                            },
                          ),
                        ],
                      )
                    ],
                    body: RefreshIndicator(
                      onRefresh: () async {
                        await Provider.of<GuildModel>(context, listen: false)
                            .updateGuilds();
                      },
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              Provider.of<GuildModel>(context).guilds.length,
                          itemBuilder: (_, position) {
                            final guild = Provider.of<GuildModel>(context)
                                .guilds[position];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(8.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ChangeNotifierProvider(
                                                  create: (_) => MessageModel(
                                                      guildId: guild.gid,
                                                      messages: []),
                                                  builder: (context, _) {
                                                    return GuildExpandedView(
                                                      guild: guild,
                                                      context: context,
                                                    );
                                                  })));
                                },
                                leading: FutureBuilder(
                                    future: DicebearServices.getAvatar(
                                        AvatarType.bottts, guild.name),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          snapshot.hasData) {
                                        print(snapshot.data.toString());
                                        return SvgPicture.string(
                                          snapshot.data.toString(),
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
                                title: Text(guild.name),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            );
                          }),
                    ),
                  );
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
