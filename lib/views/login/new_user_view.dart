import 'package:develove/services/dicebear.dart';
import 'package:develove/services/supabase/auth/signup_complete.dart';
import 'package:develove/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NewUserView extends StatefulWidget {
  const NewUserView({Key? key}) : super(key: key);

  @override
  _NewUserViewState createState() => _NewUserViewState();
}

class _NewUserViewState extends State<NewUserView> {
  final _usernameController = TextEditingController();
  bool _isValid = false;

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
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                AppBar(title: Text("Username")),
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
                                AvatarType.miniavs, _usernameController.text),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SvgPicture.string(
                                  snapshot.data.toString(),
                                  height:
                                      MediaQuery.of(context).size.width * 0.4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
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
                              "Choose your username",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(height: 30),
                            Text(
                              "Your Avatar changes based on the user name you select check it out",
                              textAlign: TextAlign.center,
                              // style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(height: 10),
                            TextField(
                              onChanged: (userName) async {
                                if (userName.isNotEmpty &&
                                    userName.length > 4 &&
                                    await isUsernameTaken(
                                        _usernameController.text)) {
                                  setState(() {
                                    _isValid = true;
                                  });
                                } else {
                                  setState(() {
                                    _isValid = false;
                                  });
                                }
                              },
                              controller: _usernameController,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                hintText: "Username",
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
                                      await updateUser(
                                          _usernameController.text[0]
                                                  .toUpperCase() +
                                              _usernameController.text
                                                  .substring(1),
                                          [],
                                          _usernameController.text);
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/home', (route) => false);
                                    }
                                  : null,
                              child: Text("Set Username"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
