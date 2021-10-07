import 'package:develove/services/supabase/auth/signup_complete.dart';
import 'package:flutter/material.dart';

class ProfileEditView extends StatefulWidget {
  const ProfileEditView({Key? key}) : super(key: key);

  @override
  _ProfileEditViewState createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _tagController = TextEditingController();

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
      child: SafeArea(
        child: Material(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          )),
          child: Scaffold(
            body: Column(
              children: [
                AppBar(
                  actions: [
                    IconButton(
                        onPressed: () async {
                          await updateUser(_nameController.text,
                              [_tagController.text], _usernameController.text);
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.done))
                  ],
                ),
                Column(
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(hintText: "Username"),
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(hintText: "Full Name"),
                    ),
                    TextField(
                      controller: _tagController,
                      decoration: InputDecoration(hintText: "Tag"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
