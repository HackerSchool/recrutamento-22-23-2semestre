import 'package:flutter/material.dart';

void main() {
  runApp(SimpleButtonApp());
}

class SimpleButtonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Simple Button App'),
        ),
        body: Center(
          child: ClickCounter(),
        ),
      ),
    );
  }
}

class ClickCounter extends StatefulWidget {
  @override
  _ClickCounterState createState() => _ClickCounterState();
}

class _ClickCounterState extends State<ClickCounter> {
  int _clickCount = 0;

  void _incrementCounter() {
    setState(() {
      _clickCount = _clickCount + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'You have clicked the button this many times:',
        ),
        Text(
          '$_clickCount',
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: Text('Click me'),
        ),
      ],
    );
  }
}
