import 'dart:ui';

import 'package:expenses_app_restarted/models/transaction.dart';
import 'package:expenses_app_restarted/widgets/add_transaction.dart';
import 'package:expenses_app_restarted/widgets/transaction_card.dart';
import 'package:expenses_app_restarted/widgets/user_transactions.dart';
import 'package:flutter/material.dart';

import 'screens/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  MaterialColor pickedColor = Colors.purple;

  final Map<String, MaterialColor> colors = {
    'Purple': Colors.purple,
    'Pink': Colors.pink,
    'Green': Colors.green
  };

  final List<Transaction> transactions = [
    // Transaction(title: 'Shoe', id: 001, amount: 20.3),
    // Transaction(title: "tshirt", id: 001, amount: 12.4),
  ];

  void _addTransaction(String title, double amount, DateTime selectedDate) {
    Transaction tx =
        Transaction(title: title, amount: amount, date: selectedDate);
    setState(() {
      transactions.add(tx);
    });
  }

  void _deleteTransaction(String id) {
    transactions.removeWhere((tx) => tx.id == id);
  }

  void _changeColor(String color) {
    setState(() {
      pickedColor = colors[color]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: pickedColor,
          accentColor: Colors.amber,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: const TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 18,
                ),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      titleMedium: const TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 19,
                  )))),
      home: MyHomePage(
        transactions: transactions,
        title: 'My Expenses',
        addTransaction: _addTransaction,
        changeColor: _changeColor,
        deleteTx: _deleteTransaction,
      ),
    );
  }
}
