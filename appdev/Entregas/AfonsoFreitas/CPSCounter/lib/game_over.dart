import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:html';

class GameOver extends StatelessWidget{
   const GameOver(this.count,this.username,{super.key});

  final int count;
  final String username;

 Future<void> writeToJson() async {
    List<dynamic> jsonList;

    final jsonString = window.localStorage['data'];
    if (jsonString != null) {
      jsonList = jsonDecode(jsonString);
    } else {
      jsonList = [];
    }

    jsonList.add({'username': username, 'score': count});

    window.localStorage['data'] = jsonEncode(jsonList);
  }

  @override
  Widget build(BuildContext context) {
    writeToJson();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Game Over',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Your Score: $count',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
    )
    );
  }
}