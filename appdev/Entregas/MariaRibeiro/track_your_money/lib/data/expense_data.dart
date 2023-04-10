import 'package:flutter/material.dart';
import 'package:track_your_money/data/hive_database.dart';
import 'package:track_your_money/models/expense_item.dart';

class ExpenseData extends ChangeNotifier{

  // list of all expenses
  List<ExpenseItem> overallExpenseList = [];

  // get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }
  
  final db = HiveDataBase();
  // prepare data to display
  void prepareData() {
    if (db.readData().isNotEmpty){
      overallExpenseList = db.readData();
    }
  }


  //add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  //delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    db.saveData(overallExpenseList);

  }

  //get weekday from a datattime object 
  String getDayName(DateTime dateTime) {
    switch(dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
      
    }
  }

  // get the date for the start of the week
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    //get todaays date
    DateTime today = DateTime.now();

    //go backwards from today to find sunday
    for (int i=0; i<7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Mon') {
        startOfWeek = today.subtract(Duration(days : i));
      }
    }

    return startOfWeek!;
  }

  // convert DataTime object to a string yyyymmdd
  String convertDateTimeToString(DateTime dateTime){
    String year = dateTime.year.toString();
    String month = dateTime.month.toString();
    if (month.length == 1){
      month = '0$month';
    }
    String day = dateTime.day.toString();
    if (day.length == 1){
      day = '0$day';
    }

    String yyyymmdd = year + month + day;

    return yyyymmdd;
  }


  // convert overall list of expenses into a daily expense summary 

  Map<String,double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {

    };

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }

    return dailyExpenseSummary;
  }

}