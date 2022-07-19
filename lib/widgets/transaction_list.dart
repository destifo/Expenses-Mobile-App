import 'package:expenses_app_restarted/models/transaction.dart';
import 'package:expenses_app_restarted/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  TransactionList({required this.transactions});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions yet',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 300,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                var e = transactions[index];
                return TransactionCard(
                    transactionTitle: e.title,
                    date: e.date,
                    transactionAmount: e.amount);
              },
              // shrinkWrap: true,
              // children: transactions.map((e) {}).toList(),
            ),
    );
  }
}
