import 'package:develove/views/home_view/home_view.dart';
import 'package:develove/views/login_view.dart';
import 'package:develove/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFF282828),
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light),
  );
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
        cardTheme: CardTheme(
          color: Color(0xFF474747),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF6ECD95),
        ),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor: Color(0xFF282828),
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        primarySwatch: Colors.green,
        primaryTextTheme: Theme.of(context)
            .primaryTextTheme
            .apply(displayColor: Color(0xFFDCDCDC), bodyColor: Colors.white),
        fontFamily: "Montserrat",
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.transparent,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 10.0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Color(0xFF282828),
          selectedIconTheme: IconThemeData(
            color: Color(0xFF6ECD95),
            size: 30,
          ),
          unselectedIconTheme: IconThemeData(
            size: 30,
          ),
        ),
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
