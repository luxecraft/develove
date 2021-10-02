import 'package:develove/views/home_view.dart';
import 'package:develove/views/login_view.dart';
import 'package:develove/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF282828),
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'],
    anonKey: dotenv.env['SUPABASE_PUBLIC_ANON'],
  );
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
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeView(),
        '/login': (context) => LoginView(),
      },
    );
  }
}
