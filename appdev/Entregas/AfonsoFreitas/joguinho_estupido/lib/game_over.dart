import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

class GameOver extends StatelessWidget{
   const GameOver(this.count,this.username,{super.key});

  final int count;
  final String username;

  /*Future<void> writeToJson() async {
    final jsonFile = File('../assets/data.json');
    List<dynamic> jsonList;

    if (await jsonFile.exists()) {
      final jsonString = await jsonFile.readAsString();
      jsonList = jsonDecode(jsonString);
    } else {
      jsonList = [];
    }

    jsonList.add({'username': username, 'score': count});

    await jsonFile.writeAsString(jsonEncode(jsonList));
  }*/

  @override
  Widget build(BuildContext context) {
    //writeToJson();

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