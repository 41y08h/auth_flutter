import 'package:auth_flutter/screens/login_screen.dart';
import 'package:auth_flutter/screens/signup_screen.dart';
import 'package:flutter/material.dart';

main() {
  runApp(MaterialApp(
    theme: ThemeData(
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
    ),
    title: "Auth",
    initialRoute: "/",
    routes: {
      "/": (context) => const LoginScreen(),
      "/signup": (context) => const SignupScreen(),
    },
  ));
}
