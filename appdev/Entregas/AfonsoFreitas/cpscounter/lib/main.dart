import 'dart:math';

import 'package:cpscounter/score_board.dart';

import 'game_main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _isPressed = false;
  final _usernameController = TextEditingController();
  String username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      /*ppBar: AppBar(
        title: const Text('My App'),
      ),*/
      body: Center(
        child:Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize : MainAxisSize.max,
          children: <Widget> [ 
            SizedBox(
              width: 700,
              child: TextFormField(
                cursorColor: Colors.white, 
                decoration: const InputDecoration(
                  iconColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,  width: 2.0),
                  ),
                  labelText: 'Enter here your username:',
                  labelStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.white,
                ),
              style: const TextStyle(color: Colors.white),
              controller: _usernameController, 

              //strutStyle: const StrutStyle(color: Colors.white),

              ),

            ),
            const SizedBox(height: 40),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 32, 32, 32),
                fixedSize: const Size.fromWidth( 700),
              ),
              onPressed: () {
                username = _usernameController.text; // move initialization here
                if(username != ''){
                  username = _usernameController.text;
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameMain(username),
                          ));
                } else {
                ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Tens que inserir um nome!"))
                      );
                }
              },
              child: const Text('Play',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 40),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 32, 32, 32),
                fixedSize: const Size.fromWidth(700),
                elevation: 2.0,
              ),
              onPressed: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ScoreBoard(),
                          ));
               setState(() {
                _isPressed = !_isPressed;
               });},
              child: const Text('Score Board',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ),
            ],
            // Other widgets in the colum
        ),
      ),
    );
    
  }
}

