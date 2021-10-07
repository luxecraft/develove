import 'package:develove/models/guild.dart';
import 'package:develove/models/message.dart';
import 'package:develove/models/user.dart' as userModel;
import 'package:develove/services/guilds.dart';
import 'package:develove/services/supabase/constants.dart';
import 'package:develove/services/user.dart';
import 'package:develove/views/home_view/pages/guilds/guild_info_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

class GuildExpandedView extends StatelessWidget {
  final Guild guild;
  final BuildContext context;

  GuildExpandedView({
    Key? key,
    required this.guild,
    required this.context,
  }) : super(key: key) {
    supabase.from('messages').stream().execute().listen((_) {
      provider.Provider.of<MessageModel>(context, listen: false)
          .updateMessages();
    });
  }

  final TextEditingController _messageEditingController =
      TextEditingController();
  // bool isValidMessage = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xFF282828),

          // gradient: LinearGradient(
          //     colors: [Color(0xFF313131), Color(0xFF282828)],
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(children: [
              AppBar(
                title: Text(guild.name),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => GuildInfoView(guild: guild)));
                      },
                      icon: Icon(Icons.info_outline))
                ],
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                      controller: ScrollController(initialScrollOffset: 100),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: provider.Provider.of<MessageModel>(context)
                          .messages
                          .length,
                      itemBuilder: (_, position) {
                        final e = provider.Provider.of<MessageModel>(context)
                            .messages[position];

                        return FutureBuilder(
                            future:
                                getUserInfo(supabase.auth.currentUser!.email!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                final user = snapshot.data as userModel.User;
                                final fromMe = user.uid == e.uid;
                                return Row(
                                  mainAxisAlignment: fromMe
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Material(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        color: fromMe
                                            ? Color(0xFF6ECD95)
                                            : Colors.white,
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              e.text,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  ?.apply(
                                                    color: Colors.black,
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
                      }),
                ),
              ),
              Material(
                elevation: 10.0,
                child: Container(
                  color: Color(0xFF282828),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              child: TextField(
                                // onChanged: (message) {
                                //   if (message.isNotEmpty) {
                                //     setState(() {
                                //       isValidMessage = true;
                                //     });
                                //   } else {
                                //     setState(() {
                                //       isValidMessage = false;
                                //     });
                                //   }
                                // },
                                keyboardType: TextInputType.multiline,
                                controller: _messageEditingController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 8.0,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  focusColor: Colors.transparent,
                                  hintText: "Message",
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send_outlined),
                          onPressed: () async {
                            final text = _messageEditingController.text;
                            _messageEditingController.clear();

                            await sendMessage(guild.gid, text);
                            await provider.Provider.of<MessageModel>(context,
                                    listen: false)
                                .updateMessages();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ])));
  }
}

List<Message> parseMessage(List<Map<String, dynamic>> data) {
  return data.map((e) => Message.fromJson(e)).toList();
}
