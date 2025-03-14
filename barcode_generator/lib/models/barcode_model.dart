class Barcode {
  final String code;
  final DateTime timestamp;

  Barcode({required this.code, DateTime? timestamp})
    : timestamp = timestamp ?? DateTime.now();

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {'code': code, 'timestamp': timestamp.millisecondsSinceEpoch};
  }

  // Create from Map for retrieval
  factory Barcode.fromMap(Map<String, dynamic> map) {
    return Barcode(
      code: map['code'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }
}
