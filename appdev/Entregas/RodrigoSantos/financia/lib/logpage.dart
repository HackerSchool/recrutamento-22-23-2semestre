// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> options = [
  "Food",
  "Entertainment",
  "Transportation",
  "Rent",
  "Bills",
];

var _selectedCategory;
var money;
var textCont;
var encodedMap;

Map<String, double> expenseMap = {
  "Food": 0,
  "Entertainment": 0,
  "Transportation": 0,
  "Rent": 0,
  "Bills": 0,
};

void main() {
  runApp(const LogPage());
}

class LogPage extends StatefulWidget {
  const LogPage({super.key});
  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  bool dataUpdated = true;

  @override
  void initState() {
    super.initState();
    textCont = TextEditingController();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    encodedMap = prefs.getString('map');
    if (encodedMap != null) {
      setState(() {
        expenseMap = Map<String, double>.from(jsonDecode(encodedMap));
      });
    }
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    encodedMap = jsonEncode(expenseMap);
    prefs.setString('map', encodedMap);
  }

  void updateMap(String key, int money) {
    expenseMap.update(key, (value) => value + money);
    setState(() {
      dataUpdated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Financia log book",
        home: Scaffold(
          appBar: AppBar(
            title: Text("Financia"),
            centerTitle: true,
            titleTextStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            backgroundColor: Colors.deepPurple.shade900,
          ),
          body: Column(children: [
            SizedBox(
              height: 60,
            ),
            Text(
              "Logbook",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurple.shade900),
            ),
            SizedBox(
              height: 25,
            ),
            TextField(
              controller: textCont,
              onChanged: (value) => money = int.parse(value),
              decoration: InputDecoration(
                  hintText: "How much money have you spent?",
                  prefixIcon: Icon(
                    Icons.attach_money_sharp,
                    color: Colors.deepPurple.shade900,
                  ),
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple.shade900))),
            ),
            SizedBox(
              height: 25,
            ),
            DropdownButton(
              hint: Text('Select a category for your expense'),
              value: _selectedCategory,
              items: options.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {
                  updateMap(_selectedCategory, money);
                  saveData();
                },
                child: Text("Add to tracking")),
            SizedBox(
              height: 50,
            ),
            Visibility(
              visible: dataUpdated,
              child: PieChart(
                dataMap: expenseMap,
                chartRadius: 150,
                chartType: ChartType.ring,
              ),
            )
          ]),
        ));
  }
}
