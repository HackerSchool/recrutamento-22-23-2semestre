import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

int _counter = 0;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Panado',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const Table(title: 'Mesa'),
    );
  }
}

class Table extends StatefulWidget {
  const Table({super.key, required this.title});

  final String title;

  @override
  State<Table> createState() => _TableState();
}

class _TableState extends State<Table> {

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
    });
  }

  //Decrementing counter after click
  Future<void> _decrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_counter > 0) {
        _counter = (prefs.getInt('counter') ?? 0) - 1;
        prefs.setInt('counter', _counter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Aqui na mesa podes comer.\n',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Tens este número de panados:\n',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '$_counter\n',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              child: const Text('Ir para a cozinha'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Kitchen(title: 'Cozinha')),
                );
              }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _decrementCounter,
        tooltip: 'Comer panado',
        child: const Icon(Icons.restaurant),
      ),
    );
  }
}

class Kitchen extends StatefulWidget {
  const Kitchen({super.key, required this.title});

  final String title;

  @override
  State<Kitchen> createState() => _KitchenState();
}

class _KitchenState extends State<Kitchen> {

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Loading counter value on start
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
    });
  }

  //Incrementing counter after click
  Future<void> _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.orange
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Aqui na cozinha podes cozinhar.\n',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Tens este número de panados:\n',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '$_counter\n',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              child: const Text('Voltar à mesa'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Table(title: 'Mesa')),
                );
              }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Cozinhar panado',
        backgroundColor: Colors.orange,
        child: const Icon(Icons.soup_kitchen),
      ),
    );
  }
}
