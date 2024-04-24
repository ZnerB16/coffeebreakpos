class Order{
  final int orderID;
  final String name;
  final String date;
  final String time;
  final double total;
  final String mode;

  Order({
    required this.orderID,
    required this.name,
    required this.date,
    required this.time,
    required this.total,
    required this.mode
  }
      );
  factory Order.fromSQfliteDatabase(Map<String, dynamic> map) => Order(
      orderID: map['order_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      total: map["total_price"] ?? 0.0,
      mode: map['mode'] ?? '',
  );
}