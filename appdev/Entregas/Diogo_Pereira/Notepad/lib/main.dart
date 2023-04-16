import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

List<String> data = [];
String response = "";

SharedPreferences ?prefs;

Future<void> readJson() async {
  response = await rootBundle.loadString('./files.json');
  data = json.decode(response);
}

Future<void> setPrefs() async {
  prefs = await SharedPreferences.getInstance();
  prefs!.setStringList('files', ['Example Title']);
  prefs!.setString('Example Title', 'Example Text');
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPrefs();
  runApp(const MyApp());
}


class TextFile {
  int _index = 0;
  String _fileName = "";
  String _text = "";

  void setFile(int index, String fileName, String text) {
    _index = index;
    _fileName = fileName;
    _text = text;
  }

  String getFileName() {return _fileName;}

  void setText(String text) {_text = text;}

  String getText() {return _text;}

  int getIndex() {return _index;}
}

TextFile file = TextFile();


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notepad',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController myController = TextEditingController();

  void newFile() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Card(
          child: Column(
            children: [
              const Text("New File Name:"),
              TextFormField(
                controller: myController,
                showCursor: true,
              ),
              ElevatedButton(
                onPressed: () {
                  if (!prefs!.getStringList('files')!.contains(myController.text)) {
                    file.setFile(-1, myController.text, "");
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FileEditor()),
                    ).then((value) => setState(() {}));
                  }
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> openFile(int index, String fileName, String text) async {
    file.setFile(index, fileName, text);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Notepad',),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            (prefs!.getStringList('files') != null && prefs!.getStringList('files')!.isNotEmpty)
                ? Expanded(
                    child: ListView.builder(
                      itemCount: prefs!.getStringList('files')!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            String fileName = prefs!.getStringList('files')![index];
                            openFile(index, fileName, prefs!.getString(fileName)!);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const FileEditor()),
                            ).then((value) => setState(() {}));
                          },
                          child: Card(
                            margin: const EdgeInsets.all(10),
                            color: Colors.amber.shade100,
                            child: ListTile(
                              title: Text(prefs!.getStringList('files')![index]),
                            ),
                          )
                        );
                      },
                    ),
                  )
                : Container(),
            ElevatedButton(
              onPressed: () {
                newFile();
              },
              child: const Text('New File'),
            ),
          ],
        ),
      ),
    );
  }
}


class FileEditor extends StatefulWidget {
  const FileEditor({Key? key}) : super(key: key);

  @override
  State<FileEditor> createState() => _FileEditorState();
}

class _FileEditorState extends State<FileEditor> {
  TextEditingController myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Future<void> saveFile() async {
    if (file.getIndex() == -1) {
      List<String> fileNames = prefs!.getStringList('files')!;
      fileNames.add(file.getFileName());
      prefs!.setStringList('files', fileNames);
    }
    prefs!.setString(file.getFileName(), myController.text);
    //File("save/files.json").writeAsStringSync(json.encode(data), flush: true);
  }

  @override
  Widget build(BuildContext context) {
    myController.text = file.getText();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(file.getFileName()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextFormField(
              controller: myController,
              showCursor: true,
              maxLines: 8,
            ),
            ElevatedButton(
              onPressed: () {
                saveFile();
                Navigator.pop(context,);
              },
              child: const Text('Save File'),
            ),
          ],
        ),
      ),
    );
  }
}