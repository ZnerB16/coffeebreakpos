class IcedCoffee{
  final int icedId;
  final String name;
  final String size;
  final double price;
  final int status;
  final String imagePath;

  IcedCoffee({
    required this.icedId,
    required this.name,
    required this.size,
    required this.price,
    required this.status,
    required this.imagePath,
  }
);
  factory IcedCoffee.fromSQfliteDatabase(Map<String, dynamic> map) => IcedCoffee(
    icedId: map['iced_id']?.toInt() ?? 0,
    name: map['name'] ?? '',
    size: map['size'] ?? '',
    price: map['price']?.toDouble() ?? 0.0,
    status: map['status'] ?? 1,
    imagePath: map["asset_path"] ?? ''
  );
}