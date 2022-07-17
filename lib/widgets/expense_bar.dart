import 'package:flutter/material.dart';

class ExpenseBar extends StatelessWidget {
  const ExpenseBar(
      {Key? key,
      required this.day,
      required this.spendingPercentage,
      required this.totSpending})
      : super(key: key);

  final String day;
  final String totSpending;
  final double spendingPercentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      child: Column(
        children: [
          FittedBox(
            child: Text(
              totSpending,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 18,
            height: 80,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPercentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ]),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(day, style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}
