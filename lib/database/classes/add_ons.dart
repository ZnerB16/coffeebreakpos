class AddOns{
  final int addOnID;
  final String name;
  final String size;
  final double price;

  AddOns({
    required this.addOnID,
    required this.name,
    required this.size,
    required this.price,
  }
      );
  factory AddOns.fromSQfliteDatabase(Map<String, dynamic> map) => AddOns(
      addOnID: map['add_on_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      size: map['size'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
  );
}