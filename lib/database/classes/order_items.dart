class OrderItems{
  final int orderID;
  final String? name;
  final String? date;
  final String? time;
  final double? total;
  final String? mode;
  final String productName;
  final String size;
  final int qty;
  final double price;

  OrderItems({
    required this.orderID,
    this.name,
    this.date,
    this.time,
    this.total,
    this.mode,
    required this.productName,
    required this.size,
    required this.qty,
    required this.price
  }
      );
  factory OrderItems.fromSQfliteDatabase(Map<String, dynamic> map) => OrderItems(
    orderID: map['order_id']?.toInt() ?? 0,
    productName: map["product_name"] ?? '',
    size: map["size"] ?? '',
    qty: map["qty"]?.toInt() ?? 0,
    price: map["price"]?.toDouble() ?? 0.0,
    name: map['name'] ?? '',
    date: map['date'] ?? '',
    time: map['time'] ?? '',
    total: map["total_price"]?.toDouble() ?? 0.0,
    mode: map['mode'] ?? '',
  );
}