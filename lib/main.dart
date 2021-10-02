import 'package:develove/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF282828),
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryTextTheme: Theme.of(context)
            .primaryTextTheme
            .apply(displayColor: Color(0xFFDCDCDC), bodyColor: Colors.white),
        fontFamily: "Montserrat",
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: SplashScreen(),
    );
  }
}
