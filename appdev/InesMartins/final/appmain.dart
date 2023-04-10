import 'dart:async';
import 'package:flutter/material.dart';

//Inicialização da app
void main() {
  runApp(App());
}

//Homepage
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      //Nome da app
      title: 'To-Do NOW',

      //Criação de splashscreen
      home: SplashScreen(),

      //Criação de duas páginas: Lista de tarefas por fazer, e lista de tarefas já feitas
      routes: {
        '/home': (context) => HomePage(),
        '/completed': (context) => CompletedTasksPage(),
      },
    );
  }
}

//Splashscreen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

//Duração do splashscreen e início do funcionamento da app
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'To-Do NOW',
          style: TextStyle(
            fontSize: 27.0,
            fontWeight: FontWeight.italic,
          ),
        ),
      ),
    );
  }
}

//Página Principal
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//Criação de duas listas diferentes
class _HomePageState extends State<HomePage> {
  List<String> _tasks = [];
  List<String> _completedTasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de tarefas:'),
        actions: [
          IconButton(
            icon: Icon(Icons.done_all),
            onPressed: () {
              Navigator.pushNamed(context, '/completed');
            },
          ),
        ],
      ),
      //Funcionamento geral das tarefas: criação e eliminação
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tasks[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      setState(() {
                        String task = _tasks.removeAt(index);
                        _completedTasks.add(task);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Add a task',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _tasks.add(_textController.text);
                      _textController.clear();
                    });
                  },
                ),
              ),
              controller: _textController,
            ),
          ),
        ],
      ),
    );
  }

  final TextEditingController _textController = TextEditingController();
}

//Página de tarefas já realizadas
class CompletedTasksPage extends StatelessWidget {
  final List<String> completedTasks;

  CompletedTasksPage({Key? key, required this.completedTasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas Concluídas!'),
      ),
      body: ListView.builder(
        itemCount: completedTasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(completedTasks[index]),
          );
        },
      ),
    );
  }
}
