import 'package:develove/views/home_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image.asset(
                        "assets/images/HeartMap.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Text(
                      "Sign up for Develove",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.apply(fontSizeDelta: -10),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      MaterialButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => HomeView()),
                              (route) => false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/GitHub.png",
                                height: 24.0,
                                width: 24.0,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                  child: Text(
                                "Sign in with Github",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.apply(
                                        color: Colors.black,
                                        fontWeightDelta: 2),
                              )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      MaterialButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => HomeView()),
                              (route) => false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/Google.png",
                                height: 24.0,
                                width: 24.0,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                  child: Text(
                                "Sign in with Google",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.apply(
                                        color: Colors.black,
                                        fontWeightDelta: 2),
                              )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      MaterialButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => HomeView()),
                              (route) => false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/Apple.png",
                                height: 24.0,
                                width: 24.0,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                  child: Text(
                                "Sign in with Apple",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.apply(
                                        color: Colors.black,
                                        fontWeightDelta: 2),
                              )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
