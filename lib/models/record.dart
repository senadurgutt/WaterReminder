class Record {
  final int amount;
  final DateTime date;
  final String? note;

  Record({required this.amount, required this.date, this.note});

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      amount: json['amount'],
      date: json['date'],
      note: json['note'],
    );
  }
}
