import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: camel_case_types

void main() {
  runApp(const MyApp());
}

String dropdownvalue = 'Brown';
BoardColor bcolor = BoardColor.brown;
String dropdownvalue1 = 'White';
PlayerColor orientation = PlayerColor.white;

// widget sem estado (sempre igual)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // widget
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const pag3(
        title: '',
      ),
    );
  }
}

class Entrypage extends StatefulWidget {
  const Entrypage({super.key, required String title});

  @override
  State<Entrypage> createState() => _EntrypageState();
}

String title = 'Username';
String str1 = 'Welcome ';
String str2 = '!';
String dropdownValue = 'Dog';

class _EntrypageState extends State<Entrypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(str1 + title + str2),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 70,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.white],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
      ),
      body: const Center(child: Selection()),
    );
  }
}

class pag2 extends StatefulWidget {
  const pag2({super.key, required String title});

  @override
  State<pag2> createState() => _pag2State();
}

class _pag2State extends State<pag2> {
  ChessBoardController control = ChessBoardController();
  int currentPage = 0;
  String text = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('The Greatest Chess Match Ever'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 70,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.white],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
      ),
      body: Center(
          child: ChessBoard(
        controller: control,
        boardColor: bcolor,
        boardOrientation: orientation,
        onMove: () {
          // Mensagem em caso de:
          //  empate 1
          control.isThreefoldRepetition()
              ? ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Draw'),
                    behavior: SnackBarBehavior.floating,
                  ),
                )
              : Null;
          // empate 2
          control.isDraw()
              ? ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Draw'),
                    behavior: SnackBarBehavior.floating,
                  ),
                )
              : Null;
          // checkmate
          control.isGameOver()
              ? ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Check Mate'),
                    behavior: SnackBarBehavior.floating,
                  ),
                )
              : Null;
        },
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          debugPrint('floating');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const Entrypage(title: 'goback');
              },
            ),
          );
        },
        child: const Icon(Icons.rotate_left),
      ),
    );
  }
}

class pag3 extends StatefulWidget {
  const pag3({super.key, required String title});

  @override
  State<pag3> createState() => _pag3State();
}

class _pag3State extends State<pag3> {
  ChessBoardController control = ChessBoardController();
  int currentPage = 0;
  String text = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            debugPrint('floating');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const Entrypage(title: 'goback');
                },
              ),
            );
          },
          child: const Icon(Icons.home),
        ),
        // the TextField widget lets the user enter text in
        body: const Center(child: Opening()));
  }
}

class Selection extends StatefulWidget {
  const Selection({super.key});

  @override
  State<Selection> createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  // ola
  var items = [
    'Brown',
    'Darkbrown',
    'Green',
    'Orange',
  ];

  var items1 = [
    'White',
    'Black',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Text('\nBoard Color'),
        DropdownButton(
          value: dropdownvalue,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
            });
          },
        ),
        const Text('\nBoard Orientation'),
        DropdownButton(
          value: dropdownvalue1,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items1.map((String items1) {
            return DropdownMenuItem(
              value: items1,
              child: Text(items1),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue1 = newValue!;
            });
          },
        ),
        const Text('\n'),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shadowColor: Colors.redAccent,
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0)),
            minimumSize: const Size(100, 40),
          ),
          onPressed: () {
            preferencescolor();
            preferencesorient();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const pag2(title: 'SecondPage');
            }));
          },
          child: const Text('Play'),
        ),
        const Text('\n'),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shadowColor: Colors.redAccent,
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0)),
            minimumSize: const Size(100, 40),
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('TestString_Key', title);
            debugPrint(title);
          },
          child: const Text('Save Data'),
        ),
        const Text('\n'),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shadowColor: Colors.redAccent,
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0)),
            minimumSize: const Size(100, 40),
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('TestString_Key');
          },
          child: const Text('Clear Data'),
        ),
      ],
    );
  }
}

void preferencescolor() {
  switch (dropdownvalue) {
    case 'Brown':
      bcolor = BoardColor.brown;
      break;
    case 'Darkbrown':
      bcolor = BoardColor.darkBrown;
      break;
    case 'Green':
      bcolor = BoardColor.green;
      break;
    case 'Orange':
      bcolor = BoardColor.orange;
      break;
    default:
      bcolor = BoardColor.brown;
  }
}

void preferencesorient() {
  switch (dropdownvalue1) {
    case 'White':
      orientation = PlayerColor.white;
      break;
    case 'Black':
      orientation = PlayerColor.black;
      break;
    default:
      orientation = PlayerColor.white;
  }
}

class Opening extends StatefulWidget {
  const Opening({super.key});

  @override
  State<Opening> createState() => _OpeningState();
}

class _OpeningState extends State<Opening> {
  // ola

  String value = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Text('Enter Username:'),
        Padding(
          padding: const EdgeInsets.all(30),
          child: TextField(
            onChanged: (enteredValue) {
              setState(() {
                title = enteredValue;
              });
            },
            decoration: const InputDecoration(
                hintText: 'Username', border: OutlineInputBorder()),
          ),
        ),
        const Text('\nOr\n\n'),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shadowColor: Colors.redAccent,
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0)),
            minimumSize: const Size(100, 40),
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            setState(() {
              value = prefs.getString('TestString_Key')!;
              title = value;
            });
          },
          child: const Text('Load Data'),
        ),
      ],
    );
  }
}
