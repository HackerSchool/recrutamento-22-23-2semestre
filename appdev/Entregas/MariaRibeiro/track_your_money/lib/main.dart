import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:track_your_money/data/expense_data.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

void main() async {

  await Hive.initFlutter();

  await Hive.openBox("expense_database");

  runApp(const MyApp());  
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}