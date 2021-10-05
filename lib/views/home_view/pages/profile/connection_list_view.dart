import 'package:develove/models/user.dart';
import 'package:develove/utils/connection.dart';
import 'package:develove/views/home_view/pages/explore/explore_page.dart';
import 'package:flutter/material.dart';

class ConnectionListView extends StatelessWidget {
  const ConnectionListView({Key? key}) : super(key: key);

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
        body: SafeArea(
            child: Column(
          children: [
            AppBar(
              title: Text("Connections"),
            ),
            FutureBuilder(
              future: getUserConnections(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return snapshot.data != null
                      ? (() {
                          final users = snapshot.data as List<User>;
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: users.length,
                            itemBuilder: (_, position) {
                              final data = users[position];
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
                                                  data.fullName ?? "",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6,
                                                ),
                                                Text('@${data.userName}'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }())
                      : Container();
                } else {
                  return Container();
                }
              },
            )
          ],
        )),
      ),
    );
  }
}

Future<List<User>> getUserConnections() async {
  List<User> users = [];
  final connections = await getConnections();

  for (int i = 0; i < connections.length; i++) {
    final user = await getUserInfoById(connections[i]['tid']);
    if (user != null) {
      users.add(user);
    }
  }

  return users;
}
