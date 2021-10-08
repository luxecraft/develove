import 'package:develove/models/user.dart';
import 'package:develove/services/supabase/connection.dart';
import 'package:develove/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class ConnectionListView extends StatelessWidget {
  const ConnectionListView({Key? key}) : super(key: key);

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
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(
                                          width: 1.0,
                                          color: Color(0xFF6ECD95))),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 80,
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListTile(
                                                leading: FutureBuilder(
                                                    future: http.get(Uri.parse(
                                                        "https://avatars.dicebear.com/api/miniavs/${data.userName}.svg")),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.connectionState ==
                                                              ConnectionState
                                                                  .done &&
                                                          snapshot.hasData) {
                                                        return SvgPicture
                                                            .string(
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                  ),
                                ),
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
