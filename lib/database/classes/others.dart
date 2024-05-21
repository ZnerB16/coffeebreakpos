class Others{
  final int croffleId;
  final String name;
  String? size;
  final double price;
  final int status;

  Others({
    required this.croffleId,
    required this.name,
    this.size,
    required this.price,
    required this.status,
  }
      );
  factory Others.fromSQfliteDatabase(Map<String, dynamic> map) => Others(
    croffleId: map['croffle_id']?.toInt() ?? 0,
    name: map['name'] ?? '',
    size: map['size'] ?? '',
    price: map['price']?.toDouble() ?? 0.0,
    status: map['status'] ?? 1,
  );
}