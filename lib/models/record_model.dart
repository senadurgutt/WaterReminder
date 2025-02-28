class RecordModel {
  final int id; // id null olabilir
  final int amount;
  final DateTime date;
  final String? note;

  RecordModel({
    required this.id,
    required this.amount,
    required this.date,
    this.note,
  });

  factory RecordModel.fromJson(Map<String, dynamic> json) {
    return RecordModel(
      id: json['id'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // 📌 ID'yi JSON'a ekle
      'date': date.toIso8601String(),
      'amount': amount,
      'note': note,
    };
  }
}
