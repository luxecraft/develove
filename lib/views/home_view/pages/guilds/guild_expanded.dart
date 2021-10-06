import 'package:develove/models/guild.dart';
import 'package:develove/models/message.dart';
import 'package:develove/models/user.dart';
import 'package:develove/services/guilds.dart';
import 'package:develove/services/supabase/constants.dart';
import 'package:develove/services/user.dart';
import 'package:develove/views/home_view/pages/guilds/guild_info_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GuildExpandedView extends StatefulWidget {
  final Guild guild;

  const GuildExpandedView({
    Key? key,
    required this.guild,
  }) : super(key: key);

  @override
  _GuildExpandedViewState createState() => _GuildExpandedViewState();
}

class _GuildExpandedViewState extends State<GuildExpandedView> {
  final TextEditingController _messageEditingController =
      TextEditingController();
  bool isValidMessage = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF313131), Color(0xFF282828)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
            future: fetchMessages(widget.guild.gid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return ChangeNotifierProvider(
                    create: (_) => MessageModel(
                        guildId: widget.guild.gid,
                        messages: snapshot.data as List<Message>),
                    builder: (context, _) {
                      return Column(children: [
                        AppBar(
                          title: Text(widget.guild.name),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => GuildInfoView(
                                              guild: widget.guild)));
                                },
                                icon: Icon(Icons.info_outline))
                          ],
                        ),
                        Expanded(
                            child: Container(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                //placeholder
                                children: Provider.of<MessageModel>(context)
                                    .messages
                                    .map((e) {
                                  return FutureBuilder(
                                      future: getUserInfo(
                                          supabase.auth.currentUser!.email!),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                                ConnectionState.done &&
                                            snapshot.hasData) {
                                          final user = snapshot.data as User;
                                          final fromMe = user.uid == e.uid;
                                          return Row(
                                            mainAxisAlignment: fromMe
                                                ? MainAxisAlignment.end
                                                : MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Material(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  color: fromMe
                                                      ? Color(0xFF6ECD95)
                                                      : Colors.white,
                                                  child: Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        e.text,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1
                                                            ?.apply(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                      ),
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
                                }).toList(),
                              ),
                            ),
                          ),
                        )),
                        Material(
                          elevation: 10.0,
                          child: Container(
                            color: Color(0xFF282828),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          controller: _messageEditingController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 8.0,
                                              horizontal: 8.0,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                borderSide: BorderSide(
                                                    color: Colors.grey)),
                                            focusColor: Colors.transparent,
                                            hintText: "Message",
                                            isDense: true,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                borderSide: BorderSide(
                                                    color: Colors.grey)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.send_outlined),
                                    onPressed: () async {
                                      await sendMessage(widget.guild.gid,
                                          _messageEditingController.text);
                                      await Provider.of<MessageModel>(context,
                                              listen: false)
                                          .updateMessages();

                                      _messageEditingController.clear();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]);
                    });
              } else {
                return SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
