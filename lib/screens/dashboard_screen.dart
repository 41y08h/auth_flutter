import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

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
              Text("Dashboard"),
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
