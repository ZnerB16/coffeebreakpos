class Croffles{
  final int croffleId;
  final String name;
  final double price;
  final int status;

  Croffles({
    required this.croffleId,
    required this.name,
    required this.price,
    required this.status,
  }
      );
  factory Croffles.fromSQfliteDatabase(Map<String, dynamic> map) => Croffles(
    croffleId: map['croffle_id']?.toInt() ?? 0,
    name: map['name'] ?? '',
    price: map['price']?.toDouble() ?? 0.0,
    status: map['status'] ?? 1,
  );
}