// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:financia/logpage.dart';
import 'package:financia/signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var userInput;
var passInput;
var username;
var password;

void main() {
  runApp(MaterialApp(
    home: Startup(),
  ));
}

class Startup extends StatefulWidget {
  const Startup({super.key});

  @override
  State<Startup> createState() => _StartupState();
}

class _StartupState extends State<Startup> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString("username") ?? "";
    password = prefs.getString("password") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    void navToSignUp() {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SignUpPage(),
      ));
    }

    void navLogPage() {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LogPage(),
      ));
    }

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Financia"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        backgroundColor: Color.fromRGBO(49, 27, 146, 1),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Hello! Please log yourself into Financia. If you don't have an account, sign up!",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.deepPurple.shade900),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          TextField(
            onChanged: (value) => userInput = value,
            decoration: InputDecoration(
                hintText: "Username",
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.deepPurple.shade900,
                )),
          ),
          TextField(
            onChanged: (value) => passInput = value,
            obscureText: true,
            decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(
                  Icons.password,
                  color: Colors.deepPurple.shade900,
                ),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple.shade900))),
          ),
          SizedBox(
            height: 50,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Builder(
                builder: (context) => ElevatedButton(
                    onPressed: () {
                      if (userInput == username && passInput == password) {
                        navLogPage();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Incorrect username or password'),
                            backgroundColor: Colors.red));
                      }
                    },
                    child: Text("Login"))),
            SizedBox(width: 25),
            Builder(
                builder: (context) => ElevatedButton(
                    onPressed: () {
                      navToSignUp();
                    },
                    child: Text("Sign up")))
          ]),
        ]),
      ),
    ));
  }
}
