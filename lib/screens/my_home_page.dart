import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/add_transaction.dart';
import '../widgets/choose_color.dart';
import '../widgets/transaction_list.dart';
import '../widgets/user_transactions.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  final Function(String title, double amount) addTransaction;
  final Function(String color) changeColor;
  // final titleController = TextEditingController();
  // final amountController = TextEditingController();
  final List<Transaction> transactions;

  MyHomePage(
      {required this.title,
      required this.addTransaction,
      required this.changeColor, required this.transactions});

  void _openTransactionEntry(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return AddTransaction(addTransaction: addTransaction);
        });
  }

  void openColorSettings(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return ChooseColor(changeColor: changeColor);
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () {
                openColorSettings(context);
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              child: const Card(
                child: Text(
                  "Chart",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TransactionList(transactions: transactions)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openTransactionEntry(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
