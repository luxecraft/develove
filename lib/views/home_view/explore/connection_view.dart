import 'package:develove/models/user.dart';
import 'package:develove/services/supabase/connection.dart';
import 'package:develove/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class ConnectionView extends StatelessWidget {
  const ConnectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getPendingConnections();
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF282828),

        // gradient: LinearGradient(
        //     colors: [Color(0xFF313131), Color(0xFF282828)],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight),
      ),
      child: Scaffold(
        body: Column(
          children: [
            AppBar(title: Text('Connection Requests')),
            FutureBuilder(
              future: getPendingConnections(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final List<User> connectionRequests =
                      snapshot.data as List<User>;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: connectionRequests.length,
                      itemBuilder: (_, position) {
                        final data = connectionRequests[position];
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
                                                    (snapshot.data
                                                            as http.Response)
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
                                          trailing: Column(
                                            children: [
                                              // supabase.auth.currentUser?.email !=
                                              //         connectionRequests[position].email
                                              //     ?
                                              OutlinedButton(
                                                onPressed: () async {
                                                  await acceptConnection(
                                                      connectionRequests[
                                                              position]
                                                          .uid);
                                                },
                                                child: Text("Accept"),
                                              ),
                                              SizedBox(width: 10.0),
                                              OutlinedButton(
                                                onPressed: () async {
                                                  await rejectConnection(
                                                      connectionRequests[
                                                              position]
                                                          .uid);
                                                },
                                                child: Text(
                                                  "Reject",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              )

                                              // : Container(),
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
                      });
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<User>> getPendingConnections() async {
  final pendingCons = await pendingConnections();
  List<User> users = [];
  for (int i = 0; i < pendingCons.length; i++) {
    User? user = await getUserInfoById(pendingCons[i]['fid']);
    user != null ? users.add(user) : null;
  }
  return users;
}
