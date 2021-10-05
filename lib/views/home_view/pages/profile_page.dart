import 'package:develove/utils/constants.dart';
import 'package:develove/utils/signup_complete.dart';
import 'package:develove/views/profile_edit_view.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    fetchUserData(
      supabase.auth.currentUser?.email ?? "",
    );
    return Column(
      children: [
        AppBar(
          title: Text("Profile"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProfileEditView()));
              },
              icon: Icon(Icons.edit_outlined),
            ),
            IconButton(
              onPressed: () async {
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
                      side: BorderSide(width: 1.0, color: Color(0xFF6ECD95))),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                supabase.auth.currentUser?.email ?? "",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        )
      ],
    );
  }
}
