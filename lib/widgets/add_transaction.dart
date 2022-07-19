import 'package:expenses_app_restarted/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  AddTransaction({Key? key, required this.addTransaction}) : super(key: key);

  final Function(String title, double amount, DateTime selectedDate)
      addTransaction;

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _pickedDate;

  void _saveTransaction() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0 || _pickedDate == null) return;

    widget.addTransaction(title, amount, _pickedDate!);
    Navigator.of(context).pop();
  }

  void _openDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        _pickedDate = value;
      });
    });
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
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _pickedDate == null
                      ? const Text(
                          'No Date Chosen',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : Text(
                          'Picked Date: ${DateFormat.yMd().format(_pickedDate!)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                  TextButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 17),
                    ),
                    onPressed: () {
                      _openDatePicker();
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: _saveTransaction,
                child: const Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.amber, fontSize: 17),
                )),
          ],
        ),
      ),
    );
  }
}
