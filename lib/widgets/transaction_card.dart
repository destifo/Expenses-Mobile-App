import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final String transactionTitle;
  final double transactionAmount;
  final DateTime date;
  final Function(String id) deleteTx;
  final String id;

  TransactionCard(
      {required this.transactionTitle,
      required this.date,
      required this.transactionAmount,
      required this.deleteTx,
      required this.id});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 16),
      child: Card(
        elevation: 7,
        child: Container(
          // TODO: apply margin and padding
          // padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 3,
                ),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Text(
                '\$${transactionAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              transactionTitle,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(date),
              style: TextStyle(color: Colors.grey[600], fontSize: 15),
            ),
            trailing: IconButton(
                onPressed: () {
                  deleteTx(id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                )),
          ),
        ),
      ),
    );
  }
}
