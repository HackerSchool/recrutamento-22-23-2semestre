import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:html';
import 'entities/score.dart';

class ScoreBoard extends StatefulWidget {
  const ScoreBoard({super.key});

  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {

  List<Score> _scoreList = <Score>[];

  Future<List<Score>> scoreBoard() async {
    var scoreList = <Score>[];

    try {
      final jsonString = window.localStorage['data'];
      if (jsonString != null) {
        final jsonData = jsonDecode(jsonString);
        for (var json in jsonData) {
          scoreList.add(Score.fromJson(json));
        }
      }
      scoreList.sort((a, b) => a.compareTo(b));
    } catch (e) {
      print('Error: $e');
    }

    return scoreList;
  }

  @override
  void initState() {
    scoreBoard().then((value) {
      setState(() {
        _scoreList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (_scoreList.isEmpty || index >= _scoreList.length || index >= 100) {
            return Container();
          }
          return ListTile(
            title: Text(
              '${index + 1}:          Score: ${_scoreList[index].score}            Username: ${_scoreList[index].username}          CPS: ${_scoreList[index].cps}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
        itemCount: _scoreList.length, // limit the number of items to 100
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.pop(
                    context);
        },
        child: const Icon(Icons.arrow_back),
      ),
  );
}
}