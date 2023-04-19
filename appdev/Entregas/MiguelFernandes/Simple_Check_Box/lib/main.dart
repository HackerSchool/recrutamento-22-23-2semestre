import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; // to generate unique IDs for each to-do item

void main() {
  runApp(const TodoListApp());
}

class Todo {
  final String id;
  final String task;
  final String imageUrl; // new field for image URL
  bool isDone;

  Todo({
    required this.id,
    required this.task,
    required this.imageUrl,
    required this.isDone,
  });
}

class TodoList {
  List<Todo> items = [];
}

class TodoListApp extends StatefulWidget {
  const TodoListApp({super.key});

  @override
  TodoListAppState createState() => TodoListAppState();
}

class TodoListAppState extends State<TodoListApp> {
  final TextEditingController _textEditingController = TextEditingController();
  final TodoList _todoList = TodoList();
  List<String> _imageUrls = [
    "https://cdna.artstation.com/p/assets/images/images/054/380/818/large/miishuvt-conejito.jpg?1664398100",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0ik1CA2m0P00OMwz7lmqAW2U1yQBOuk50VQ&usqp=CAU",
    "https://cdnb.artstation.com/p/assets/images/images/029/447/759/smaller_square/mila-levon-1.jpg?1597591004",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRsZwDWKvakv_st0142yGNXSZalmoQVkDU8I-jzsIADcg1UL-pIb9v1ktQr3xo2EYKRY0",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1VqMTVxb0cnawytzMGqw6CTEWmy-HsDrMyDhGsPZ61714r_6Bvm7OoVoLUlmBoJinnt0&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZk51EXFv67CF2JTVzJkmHbQ1QNcrd-Kb-ow&usqp=CAU"
  ];
  int _nextImageUrlIndex = 0;

  String getNextImageUrl() {
    final nextImageUrl = _imageUrls[_nextImageUrlIndex];
    _nextImageUrlIndex = (_nextImageUrlIndex + 1) % _imageUrls.length;
    return nextImageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      home: Scaffold(
        appBar: AppBar(
          title: Text('To-Do List'),
        ),
        body: Column(
          children: <Widget>[
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Add a task',
              ),
              onSubmitted: (String task) {
                setState(() {
                  _todoList.items.add(Todo(
                    id: Uuid().v4(),
                    task: task,
                    isDone: false,
                    imageUrl: getNextImageUrl(),
                  ));
                  _textEditingController.clear();
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todoList.items.length,
                itemBuilder: (BuildContext context, int index) {
                  final Todo todo = _todoList.items[index];
                  return ListTile(
                    leading: SizedBox(
                      width: 80.0,
                      height: 80.0, // A ALTURA NÃO FUNCIONA??!??!?!?!??!
                      child: Image.network(
                        todo.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ), // display image on left side
                    title: Text(todo.task),
                    trailing: Checkbox(
                      value: todo.isDone,
                      onChanged: (bool? value) {
                        setState(() {
                          todo.isDone = value ?? false;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
