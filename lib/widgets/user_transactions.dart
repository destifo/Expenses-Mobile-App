import 'package:expenses_app_restarted/widgets/add_transaction.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_list.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> transactions = [
    Transaction(title: 'Shoe', id: 001, amount: 20.3),
    Transaction(title: "tshirt", id: 001, amount: 12.4),
  ];

  void _addTransaction(String title, double amount) {
    Transaction tx =
        Transaction(title: title, id: transactions.length + 1, amount: amount);
    setState(() {
      transactions.add(tx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AddTransaction(addTransaction: _addTransaction),
        TransactionList(transactions: transactions)
      ],
    );
  }
}
