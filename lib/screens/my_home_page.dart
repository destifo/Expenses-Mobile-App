import 'package:expenses_app_restarted/widgets/chart.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/add_transaction.dart';
import '../widgets/choose_color.dart';
import '../widgets/transaction_list.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  final Function(String title, double amount, DateTime selectedDate)
      addTransaction;
  final Function(String color) changeColor;
  final Function(String id) deleteTx;
  // final titleController = TextEditingController();
  // final amountController = TextEditingController();
  final List<Transaction> transactions;

  MyHomePage(
      {required this.title,
      required this.addTransaction,
      required this.changeColor,
      required this.transactions,
      required this.deleteTx});

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

  List<Transaction> get _recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
            ),
            TransactionList(
              transactions: transactions,
              deleteTx: deleteTx,
            )
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
