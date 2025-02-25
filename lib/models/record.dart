class Record {
  final int amount;
  final DateTime date;

  Record({required this.amount, required this.date});

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(amount: json['amount'], date: json['date']);
  }
}
