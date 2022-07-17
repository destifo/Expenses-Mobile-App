class Transaction {
  final String title;
  final int id;
  final DateTime date = DateTime.now();
  final double amount;

  Transaction({
    required this.title,
    required this.id,
    required this.amount,
  });
}