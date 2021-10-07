import 'package:develove/models/user.dart';
import 'package:develove/services/supabase/connection.dart';
import 'package:develove/services/user.dart';
import 'package:flutter/material.dart';

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
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      connectionRequests[position].fullName ??
                                          "",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    Text(
                                        '@${connectionRequests[position].userName}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    // supabase.auth.currentUser?.email !=
                                    //         connectionRequests[position].email
                                    //     ?
                                    OutlinedButton(
                                      onPressed: () async {
                                        await acceptConnection(
                                            connectionRequests[position].uid);
                                      },
                                      child: Text("Accept"),
                                    ),
                                    SizedBox(width: 10.0),
                                    OutlinedButton(
                                      onPressed: () async {
                                        await rejectConnection(
                                            connectionRequests[position].uid);
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
