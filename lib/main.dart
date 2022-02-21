import 'package:auth_flutter/screens/dashboard_screen.dart';
import 'package:auth_flutter/screens/login_screen.dart';
import 'package:auth_flutter/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  // Check if user is already logged in
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  bool isAuthenticated = token != null;

  runApp(MaterialApp(
    theme: ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
    ),
    title: "Auth",
    initialRoute: isAuthenticated ? "dashboard" : "login",
    routes: {
      "login": (context) => const LoginScreen(),
      "signup": (context) => const SignupScreen(),
      "dashboard": (context) => const DashboardScreen(),
    },
  ));
}
