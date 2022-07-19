class Transaction {
  final String title;
  final String id = DateTime.now().toString();
  DateTime date = DateTime.now();
  final double amount;

  Transaction({
    required this.title,
    required this.amount,
    required this.date,
  });
}
