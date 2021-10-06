import 'package:develove/models/user.dart';
import 'package:develove/services/shared_preferences.dart';
import 'package:develove/services/supabase/constants.dart';
import 'package:develove/services/user.dart';
import 'package:develove/views/home_view/home_view.dart';
import 'package:develove/views/home_view/pages/profile/connection_list_view.dart';
import 'package:develove/views/home_view/pages/profile/profile_edit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserInfo(supabase.auth.currentUser!.email!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final user = snapshot.data as User;
            return Column(
              children: [
                AppBar(
                  title: Text("Profile"),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ProfileEditView()));
                      },
                      icon: Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      onPressed: () async {
                        await SharedPreferencesService
                            .removeFromSharedPreference('avatar');
                        await supabase.auth.signOut();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login',
                          (route) => false,
                        );
                      },
                      icon: Icon(
                        Icons.logout_outlined,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                                width: 1.0, color: Color(0xFF6ECD95))),
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.green,
                                      radius: 45,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: FutureBuilder(
                                              future: getUserAvatar(supabase
                                                  .auth.currentUser!.email!),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  return SvgPicture.string(
                                                      snapshot.data as String);
                                                } else {
                                                  return CircularProgressIndicator();
                                                }
                                              }),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Tags",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children:
                                                user.tags.map((String tag) {
                                              print(tag);
                                              return Card(
                                                color: Color(0xFF282828),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(tag),
                                                ),
                                              );
                                            }).toList(),
                                          )
                                        ])
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user.fullName ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          Text(
                                            '@${user.userName}',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                      SizedBox(height: 20),
                      ListView(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ConnectionListView()));
                            },
                            title: Text("My Connections"),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            );
          }
        });
  }
}
