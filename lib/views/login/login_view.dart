import 'package:develove/services/supabase/auth/auth_state.dart';
import 'package:develove/services/supabase/constants.dart';
// import 'package:develove/home_view.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/src/supabase_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends AuthState<LoginView> {
  // ignore: unused_field
  bool _isLoading = false;

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    await supabase.auth.signInWithProvider(Provider.google,
        options: AuthOptions(
          redirectTo: 'org.luxecraft.develove://login-callback/',
        ));

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _signInWithGithub() async {
    setState(() {
      _isLoading = true;
    });
    await supabase.auth.signInWithProvider(Provider.github,
        options: AuthOptions(
          redirectTo: 'org.luxecraft.develove://login-callback/',
        ));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        _signInWithGithub();
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
                                      color: Colors.black, fontWeightDelta: 2),
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
                        _signInWithGoogle();
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
                                      color: Colors.black, fontWeightDelta: 2),
                            )),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(height: 16),
                    // MaterialButton(
                    //   color: Colors.white,
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8.0)),
                    //   onPressed: () {
                    //     Navigator.pushAndRemoveUntil(
                    //         context,
                    //         MaterialPageRoute(builder: (_) => HomeView()),
                    //         (route) => false);
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(12.0),
                    //     child: Row(
                    //       children: [
                    //         Image.asset(
                    //           "assets/images/Apple.png",
                    //           height: 24.0,
                    //           width: 24.0,
                    //         ),
                    //         SizedBox(
                    //           width: 20.0,
                    //         ),
                    //         Expanded(
                    //             child: Text(
                    //           "Sign in with Apple",
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .subtitle1
                    //               ?.apply(
                    //                   color: Colors.black, fontWeightDelta: 2),
                    //         )),
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
