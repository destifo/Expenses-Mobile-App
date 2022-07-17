import 'package:expenses_app_restarted/models/transaction.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  AddTransaction({Key? key, required this.addTransaction}) : super(key: key);

  final Function(String title, double amount) addTransaction;

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void _saveTransaction() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0) return;

    widget.addTransaction(title, amount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: "Title"),
              controller: titleController,
              onSubmitted: (_) {
                _saveTransaction();
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) {
                _saveTransaction();
              },
            ),
            TextButton(
                onPressed: _saveTransaction,
                child: const Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.amber),
                ))
          ],
        ),
      ),
    );
  }
}
