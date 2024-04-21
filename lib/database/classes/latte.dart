class Latte{
  final int latteId;
  final String name;
  final String size;
  final double price;
  final int status;

  Latte({
    required this.latteId,
    required this.name,
    required this.size,
    required this.price,
    required this.status
  }
      );
  factory Latte.fromSQfliteDatabase(Map<String, dynamic> map) => Latte(
      latteId: map['latte_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      size: map['size'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      status: map['status'] ?? 1
  );
}