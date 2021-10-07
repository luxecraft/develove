import 'package:develove/services/supabase/auth/signup_complete.dart';
import 'package:flutter/material.dart';

class NewUserView extends StatelessWidget {
  NewUserView({Key? key}) : super(key: key);
  final _usernameController = TextEditingController();

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
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                AppBar(title: Text("Username")),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Choose your username"),
                          SizedBox(height: 10),
                          TextField(
                            controller: _usernameController,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              focusColor: Colors.transparent,
                              fillColor: Color(0xFF434343),
                            ),
                          ),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await updateUser(
                              _usernameController.text[0].toUpperCase() +
                                  _usernameController.text.substring(1),
                              [],
                              _usernameController.text);
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (route) => false);
                        },
                        child: Text("Set Username"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
