import 'package:expenses_app_restarted/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import 'expense_bar.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactions {
    int weekDays = 7;
    return List.generate(weekDays, (index) {
      double totAmount = 0;
      final weekDay = DateTime.now().subtract(Duration(days: index));

      for (int i = 0; i < recentTransactions.length; i++) {
        final tx = recentTransactions[i];
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totAmount += tx.amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'amount': totAmount};
    });
  }

  double get totalSpending {
    return groupedTransactions.fold(0.0, (previousValue, txData) {
      double currAmount = txData['amount'] as double;
      return previousValue + currAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        height: 150,
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
        child: Row(
          children: groupedTransactions.map((transactionData) {
            final day = transactionData['day'] as String;
            final double totAmount = transactionData['amount'] as double;
            final spendingPercentage =
                totalSpending == 0 ? 0.0 : totAmount / totalSpending;
            return Flexible(
              fit: FlexFit.tight,
              child: ExpenseBar(
                day: day,
                totSpending: totAmount.toStringAsFixed(2),
                spendingPercentage: spendingPercentage,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
