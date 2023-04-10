import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

// Ideally there would be another API call / json file for this
const Map<String, Color> COLORS = {
  "normal": Color.fromARGB(255, 196, 190, 148),
  "water": Colors.blue,
  "fire": Colors.orange,
  "fighting": Colors.red,
  "flying": Color.fromARGB(255, 236, 148, 251),
  "grass": Color.fromARGB(255, 62, 200, 62),
  "poison": Colors.purple,
  "electric": Color.fromARGB(255, 231, 211, 33),
  "ground": Color.fromARGB(255, 235, 199, 101),
  "psychic": Color.fromARGB(255, 236, 50, 112),
  "rock": Color.fromARGB(255, 113, 78, 65),
  "ice": Color.fromARGB(255, 136, 214, 253),
  "bug": Color.fromARGB(255, 131, 207, 32),
  "dragon": Color.fromARGB(255, 70, 17, 131),
  "ghost": Color.fromARGB(255, 51, 18, 90),
  "dark": Color.fromARGB(255, 43, 5, 5),
  "steel": Colors.grey,
  "fairy": Color.fromARGB(255, 235, 117, 157),
};

// This would also be another API call / json read
// pokedex range for each generation of index (1st gen from 1 to 151)
const Map<String, List<int>> GEN = {
  "I": [1, 151],
  "II": [151, 251],
  "III": [251, 386],
  "IV": [386, 493],
  "V": [493, 694],
  "VI": [649, 721]
};

// it's a singleton! /s
String gen = "I";

void main() async {
  // Initialize the SharedPreferences instance
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Get the stored value or set a default value if it's not stored
  gen = prefs.getString('gen') ?? "I";
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: RootPage());
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  dynamic poke1;
  dynamic poke2;

  Future<void> fetchData() async {
    Random r = new Random();
    int min = GEN[gen]![0];
    int max = GEN[gen]![1];
    int rand1 = min + r.nextInt(max - min + 1);
    int rand2 = min + r.nextInt(max - min + 1);

    final response1 =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/${rand1}'));
    final response2 =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/${rand2}'));
    if (response1.statusCode == 200 && response2.statusCode == 200) {
      setState(() {
        poke1 = json.decode(response1.body);
        poke2 = json.decode(response2.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void settingsSelect(BuildContext context, int item) {
    if (item == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Settings()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (poke1 == null || poke2 == null) {
      return CircularProgressIndicator();
    } else {
      return Scaffold(
          appBar: AppBar(
              actions: [
                PopupMenuButton(
                    onSelected: (item) => settingsSelect(context, item),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 0,
                            child: Text("Settings"),
                          )
                        ])
              ],
              title: Text("Poke Roullete"),
              centerTitle: true,
              backgroundColor: Colors.red),
          floatingActionButton: FloatingActionButton(
            onPressed: fetchData,
            backgroundColor: Colors.red,
            child: const Icon(Icons.refresh),
          ),
          body: Container(
            // padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 70.0, right: 70.0),
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            // color: Colors.grey,
                            image: DecorationImage(
                              image: NetworkImage(
                                  poke1['sprites']['front_default']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${poke1['name'][0].toUpperCase()}${poke1['name'].substring(1)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 7.0, right: 7.0, top: 3.0, bottom: 3.0),
                              decoration: BoxDecoration(
                                  color:
                                      COLORS[poke1['types'][0]['type']['name']],
                                  borderRadius: BorderRadius.circular(3.0)),
                              child: Text(
                                poke1['types'][0]['type']['name'].toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("EXP: ${poke1['base_experience']}"),
                                SizedBox(width: 8),
                                Text(''),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('H: ${poke1['height']}'),
                                SizedBox(width: 8),
                                Text('W: ${poke1['weight']}'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.withOpacity(0.9),
                        ),
                      ),
                      Text(
                        'vs',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 70.0, right: 70.0),
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            // color: Colors.grey,
                            // borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(
                                  poke2['sprites']['front_default']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${poke2['name'][0].toUpperCase()}${poke2['name'].substring(1)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 7.0, right: 7.0, top: 3.0, bottom: 3.0),
                              decoration: BoxDecoration(
                                  color:
                                      COLORS[poke2['types'][0]['type']['name']],
                                  borderRadius: BorderRadius.circular(3.0)),
                              child: Text(
                                poke2['types'][0]['type']['name'].toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("EXP: ${poke2['base_experience']}"),
                                SizedBox(width: 8),
                                Text(""),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('H: ${poke2['height']}'),
                                SizedBox(width: 8),
                                Text('W: ${poke2['weight']}'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
    }
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Settings'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text("Pick a generation",
                    style:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0)),
                margin: EdgeInsets.only(
                  bottom: 100.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RomanNumeralButton(text: 'I'),
                  RomanNumeralButton(text: 'II'),
                  RomanNumeralButton(text: 'III'),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RomanNumeralButton(text: 'IV'),
                  RomanNumeralButton(text: 'V'),
                  RomanNumeralButton(text: 'VI'),
                ],
              ),
            ],
          ),
        ));
  }
}

class RomanNumeralButton extends StatelessWidget {
  final String text;

  const RomanNumeralButton({Key? key, required this.text}) : super(key: key);

  static Future<void> saveConfig(String new_gen) async {
    gen = new_gen;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('gen', new_gen);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: CircleBorder(),
            padding: EdgeInsets.all(30.0)),
        onPressed: () {
          saveConfig(text);
        },
        child: Text(text, style: TextStyle(fontSize: 15.0)));
  }
}
