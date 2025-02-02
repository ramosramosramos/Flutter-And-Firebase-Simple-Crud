import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/second.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final username = TextEditingController();
    final password = TextEditingController();

    void login() {
      if (username.text == "admin" && password.text == "admin") {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SecondPage()),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("Invalid username or password"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Close"),
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: username,
                    decoration: InputDecoration(
                      hintText: "Enter your username",
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: password,
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                    ),
                  ),
                ),
              Padding(padding: EdgeInsets.all(10)),
                TextButton.icon(
                  onPressed: login,
                  label: const Text("Login"),
                  icon: const Icon(Icons.login),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurple),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
