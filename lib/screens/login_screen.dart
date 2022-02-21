import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = "";
  String password = "";

  void handleSubmit() async {
    http.Response response = await http.post(
      Uri.parse("http://192.168.0.104:5000/login"),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Save token in shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", data["token"]);

      Navigator.of(context)
          .pushNamedAndRemoveUntil("/dashboard", (route) => false);
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(data["error"]["message"]),
        duration: const Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Username",
                ),
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              TextField(
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  hintText: "Password",
                ),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: handleSubmit,
                child: const Text("Login"),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "signup");
                    },
                    child: const Text("Sign up"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
