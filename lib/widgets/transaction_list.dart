import 'package:expenses_app_restarted/models/transaction.dart';
import 'package:expenses_app_restarted/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  TransactionList({required this.transactions, required this.deleteTx});
  final Function(String id) deleteTx;
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return transactions.isEmpty
            ? Column(
                children: [
                  Text(
                    'No transactions yet',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.7,
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
                    transactionAmount: e.amount,
                    deleteTx: deleteTx,
                    id: e.id,
                  );
                },
                // shrinkWrap: true,
                // children: transactions.map((e) {}).toList(),
              );
      },
    );
  }
}
