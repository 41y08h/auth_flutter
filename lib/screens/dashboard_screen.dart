import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String username = "";

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  void getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Map<String, dynamic> user =
          JwtDecoder.decode(prefs.getString('token') ?? "");
      username = user['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    void onLogoutButtonPressed() async {
      // Remove the token from the local storage
      // Navigate to the login screen
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      Navigator.of(context).pushReplacementNamed('login');
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome @$username"),
              TextButton.icon(
                onPressed: onLogoutButtonPressed,
                icon: Icon(Icons.logout),
                label: Text("Logout"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
