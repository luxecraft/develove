import 'package:develove/home_view.dart';
import 'package:develove/views/login/login_view.dart';
import 'package:develove/views/login/new_user_view.dart';
import 'package:develove/views/login/splash_view.dart';
import 'package:develove/views/onboard_view/onboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF282828),
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_PUBLIC_ANON']!,
  );
  runApp(App());
}

final navigationKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationKey,
      theme: ThemeData(
        backgroundColor: Color(0xFF2D2D2D),
        cardTheme: CardTheme(
          color: Color(0xFF474747),
          elevation: 5.0,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF6ECD95),
        ),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Color(0xFF282828),
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          elevation: 0.0,
          backgroundColor: Color(0xFF2D2D2D),
        ),
        primarySwatch: MaterialColor(0xFF59AF77, {
          50: Color(0xFF59AF77).withOpacity(0.1),
          100: Color(0xFF59AF77).withOpacity(0.2),
          200: Color(0xFF59AF77).withOpacity(0.3),
          300: Color(0xFF59AF77).withOpacity(0.4),
          400: Color(0xFF59AF77).withOpacity(0.5),
          500: Color(0xFF59AF77).withOpacity(0.6),
          600: Color(0xFF59AF77).withOpacity(0.7),
          700: Color(0xFF59AF77).withOpacity(0.8),
          800: Color(0xFF59AF77).withOpacity(0.9),
          900: Color(0xFF59AF77).withOpacity(1),
        }),
        primaryTextTheme: Theme.of(context)
            .primaryTextTheme
            .apply(displayColor: Color(0xFFDCDCDC), bodyColor: Colors.white),
        fontFamily: "Montserrat",
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF2D2D2D),
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
        '/': (context) => SplashView(),
        '/onboard': (context) => OnboardView(),
        '/home': (context) => HomeView(),
        '/newUser': (context) => NewUserView(),
        '/login': (context) => LoginView(),
      },
    );
  }
}
