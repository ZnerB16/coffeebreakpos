class Others{
  final int otherID;
  final String name;
  String? size;
  final double price;
  final int status;

  Others({
    required this.otherID,
    required this.name,
    this.size,
    required this.price,
    required this.status,
  }
      );
  factory Others.fromSQfliteDatabase(Map<String, dynamic> map) => Others(
    otherID: map['product_id']?.toInt() ?? 0,
    name: map['name'] ?? '',
    size: map['size'] ?? '',
    price: map['price']?.toDouble() ?? 0.0,
    status: map['status'] ?? 1,
  );
}