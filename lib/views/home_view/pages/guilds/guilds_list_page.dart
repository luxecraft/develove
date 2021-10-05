import 'package:develove/views/home_view/pages/guilds/guild_expanded.dart';
import 'package:flutter/material.dart';

class Guild {
  late String name;
  late List<String> members;
  late String uid;

  Guild({required this.name});
}

class GuildListPage extends StatelessWidget {
  GuildListPage({Key? key}) : super(key: key);
  final List<Guild> _guilds = [
    Guild(name: "Develove"),
    Guild(name: "Redstone masterminds"),
    Guild(name: "Web 3 hype")
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text("Guilds"),
        ),
        ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (_, position) {
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => GuildExpandedView(
                          name: _guilds[position].name, id: "nkjdksnfnsf")),
                );
              },
              title: Text(_guilds[position].name),
              trailing: Icon(Icons.arrow_forward_ios),
            );
          },
        ),
      ],
    );
  }
}
