class Waffles{
  final int waffleId;
  final String name;
  final double price;
  final int status;

  Waffles({
    required this.waffleId,
    required this.name,
    required this.price,
    required this.status,
  }
      );
  factory Waffles.fromSQfliteDatabase(Map<String, dynamic> map) => Waffles(
    waffleId: map['croffle_id']?.toInt() ?? 0,
    name: map['name'] ?? '',
    price: map['price']?.toDouble() ?? 0.0,
    status: map['status'] ?? 1,
  );
}