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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.15,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: FittedBox(
                child: Text(
                  '\$${totSpending}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              width: 18,
              height: constraints.maxHeight * 0.6,
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
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            SizedBox(
              child: Text(day, style: Theme.of(context).textTheme.titleSmall),
              height: constraints.maxHeight * 0.15,
            ),
          ],
        );
      },
    );
  }
}
