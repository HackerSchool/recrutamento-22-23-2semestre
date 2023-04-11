
import 'package:flutter/material.dart';
import 'game_over.dart';
import 'dart:async';

class GameMain extends StatefulWidget {
  final String username;
  const GameMain(this.username,{super.key});
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<GameMain> {

  int _seconds = 10;
  int _count = 0;
  Timer? _timer;
  bool _showButton = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _count++; 
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if(_seconds == 0 ){
          _stopTimer();
        }else{
          _seconds--;
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    Navigator.pushReplacement(context,
                    MaterialPageRoute(
                      builder: (context) => GameOver(_count, widget.username),
                    ));
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = 10;
      _showButton = false;
    });
  }

  void _incrementCounter() {
    setState(() {
      if(_seconds > 0){
        _count++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: $_count',
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            Text('Seconds: $_seconds',
              style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _count == 0 ? _startTimer : _incrementCounter,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<CircleBorder>(
                      const CircleBorder()
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(100.0),
                     ),
                      minimumSize: MaterialStateProperty.all<Size>(const Size(200, 50)),

                    ),
                  child: _count == 0 ? const Text('Start', 
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    ) : const Text('PRESS HARDER',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )
                ),

              ],
            ),
            const SizedBox(height: 16),
            if(_showButton)
              ElevatedButton(
                onPressed: _resetTimer,
                child: const Text('Reset'),
              ),
          ],
        ),
      ),
    );
  }
}
