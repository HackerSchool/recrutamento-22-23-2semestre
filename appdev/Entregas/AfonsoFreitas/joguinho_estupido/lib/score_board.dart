import 'package:flutter/material.dart';
import 'dart:convert';
import 'entities/score.dart';
import 'package:flutter/services.dart' show rootBundle;

class ScoreBoard extends StatefulWidget {
  const ScoreBoard({super.key});

  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {

  List<Score> _scoreList = <Score>[];

  Future<List<Score>> scoreBoard() async {
    var scoreList = <Score>[];

    final jsonString = await rootBundle.loadString('assets/data.json');
    for(var json in jsonDecode(jsonString)){
      scoreList.add(Score.fromJson(json));
      scoreList.sort( (a,b) => a.compareTo(b));
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
          if (index >= 100) {
            return null; // return null for indexes above 100 to skip rendering
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