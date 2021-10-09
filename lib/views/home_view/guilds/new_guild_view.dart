import 'package:develove/models/guild.dart';
import 'package:develove/services/dicebear.dart';
import 'package:develove/services/guilds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NewGuildView extends StatefulWidget {
  const NewGuildView({Key? key}) : super(key: key);

  @override
  _NewGuildViewState createState() => _NewGuildViewState();
}

class _NewGuildViewState extends State<NewGuildView> {
  final _guildnameController = TextEditingController();
  bool _isValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          AppBar(title: Text("New Guild")),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.3,
                    backgroundColor: Color(0xFF6ECD95),
                    child: FutureBuilder(
                      future: DicebearServices.getAvatar(
                          AvatarType.bottts, _guildnameController.text),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SvgPicture.string(
                            snapshot.data.toString(),
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * 0.4,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Text(
                        "Choose guild name",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Guild avatar changes based on the guild name you choose check it out",
                        textAlign: TextAlign.center,
                        // style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        onChanged: (guildName) async {
                          if (guildName.isNotEmpty && guildName.length > 4) {
                            setState(() {
                              _isValid = true;
                            });
                          } else {
                            setState(() {
                              _isValid = false;
                            });
                          }
                        },
                        controller: _guildnameController,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          hintText: "Guild Name",
                          isDense: true,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          focusColor: Colors.transparent,
                          fillColor: Color(0xFF434343),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: _isValid
                            ? () async {
                                await createNewGuild(
                                    _guildnameController.text, [""]);
                                await Provider.of<GuildModel>(context,
                                        listen: false)
                                    .updateGuilds();
                                Navigator.pop(context);
                              }
                            : null,
                        child: Text("Create Guild"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
