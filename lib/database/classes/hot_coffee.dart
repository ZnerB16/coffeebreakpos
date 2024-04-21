class HotCoffee{
  final int hotId;
  final String name;
  final double price;
  final bool status;

  HotCoffee({
    required this.hotId,
    required this.name,
    required this.price,
    required this.status,
  }
      );
  factory HotCoffee.fromSQfliteDatabase(Map<String, dynamic> map) => HotCoffee(
      hotId: map['hot_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      status: map['status'] ?? true,
  );
}