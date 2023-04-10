// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

// ignore: unused_import
import 'dart:async';
import 'package:financia/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var username;
var password;
var name;

void main() {
  runApp(MaterialApp(
    home: SignUpPage(),
  ));
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final nameCont = TextEditingController();
  final usernameCont = TextEditingController();
  final passwordCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameCont.text = prefs.getString('name') ?? '';
      usernameCont.text = prefs.getString('username') ?? '';
      passwordCont.text = prefs.getString('password') ?? '';
    });
  }

  Future<void> saveLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', nameCont.text);
    prefs.setString('username', usernameCont.text);
    prefs.setString('password', passwordCont.text);
  }

  @override
  Widget build(BuildContext context) {
    void navToStartup() {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Startup(),
      ));
    }

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Financia"),
            centerTitle: true,
            titleTextStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            backgroundColor: Colors.deepPurple.shade900,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please enter the relevant data in each of the fields below.",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(221, 27, 27, 27)),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                controller: nameCont,
                decoration: InputDecoration(
                    hintText: "What's your name?",
                    prefixIcon: Icon(
                      Icons.assignment_ind_rounded,
                      color: Colors.deepPurple.shade900,
                    )),
              ),
              TextField(
                controller: usernameCont,
                decoration: InputDecoration(
                    hintText: "Enter a username",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.deepPurple.shade900,
                    )),
              ),
              TextField(
                controller: passwordCont,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Enter a password",
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.deepPurple.shade900,
                    ),
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepPurple.shade900))),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                  onPressed: () {
                    name = nameCont.text;
                    username = usernameCont.text;
                    password = passwordCont.text;
                    saveLoginData();
                    navToStartup();
                  },
                  child: Text("Save login data"))
            ],
          )),
    );
  }
}
