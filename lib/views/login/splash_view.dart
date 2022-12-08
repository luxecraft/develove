import 'dart:async';

import 'package:develove/main.dart';
import 'package:develove/services/supabase/constants.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  StreamSubscription<AuthState>? _authSubscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    authWrapper();
    _authSubscription ??= supabase.auth.onAuthStateChange.listen(authChange);
  }

  void authWrapper() async {
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }
    final session = supabase.auth.currentSession;
    if (session == null) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }
  }

  Future<void> authChange(AuthState authState) async {
    final event = authState.event;
    switch (event) {
      case AuthChangeEvent.signedIn:
        navigationKey.currentState!
            .pushNamedAndRemoveUntil('/home', (route) => false);
        break;
      case AuthChangeEvent.signedOut:
        navigationKey.currentState!
            .pushNamedAndRemoveUntil('/login', (route) => false);
        break;
      case AuthChangeEvent.userDeleted:
        navigationKey.currentState!
            .pushNamedAndRemoveUntil('/login', (route) => false);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
