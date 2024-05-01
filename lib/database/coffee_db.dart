import 'package:coffee_break_pos/database/classes/croffles.dart';
import 'package:coffee_break_pos/database/classes/hot_coffee.dart';
import 'package:coffee_break_pos/database/classes/iced_coffee.dart';
import 'package:coffee_break_pos/database/classes/latte.dart';
import 'package:sqflite/sqflite.dart';
import 'classes/order.dart';
import 'classes/order_items.dart';
import 'database_service.dart';

class CoffeeDB{
  final icedTable = 'iced_coffee';
  final hotTable = 'hot_coffee';
  final latteTable = 'latte';
  final crofflesTable = 'croffles';
  final ordersTable = 'orders';
  final orderItemsTable = 'order_items';
  final employeeTable = 'employee';
  final dtrTable = 'dtr';

  Future<void> createTable(Database database) async {
    await database.execute(
      ''' CREATE TABLE IF NOT EXISTS $icedTable(
      "iced_id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "size" TEXT NOT NULL,
      "price" REAL NOT NULL,
      "status" BOOL DEFAULT 1 NOT NULL,
      "asset_path" TEXT,
      PRIMARY KEY("iced_id" AUTOINCREMENT)
      );
      '''
    );

    await database.execute(
      ''' CREATE TABLE IF NOT EXISTS $hotTable(
      "hot_id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "price" REAL NOT NULL,
      "status" BOOL DEFAULT 1 NOT NULL,
      "asset_path" TEXT,
      PRIMARY KEY("hot_id" AUTOINCREMENT)
      );
      '''
    );

    await database.execute(
      ''' CREATE TABLE IF NOT EXISTS $latteTable(
      "latte_id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "size" TEXT NOT NULL,
      "price" REAL NOT NULL,
      "status" BOOL DEFAULT 1 NOT NULL,
      "asset_path" TEXT,
      PRIMARY KEY("latte_id" AUTOINCREMENT)
      );
      '''

    );
    await database.execute(
      ''' CREATE TABLE IF NOT EXISTS $crofflesTable(
      "croffle_id" INTEGER NOT NULL,  
      "name" TEXT NOT NULL,
      "price" REAL NOT NULL,
      "status" BOOL DEFAULT 1 NOT NULL,
      "asset_path" TEXT,
      PRIMARY KEY("croffle_id" AUTOINCREMENT)
      );
      '''
    );

    await database.execute(
      ''' CREATE TABLE IF NOT EXISTS $ordersTable(
      "order_id" INTEGER NOT NULL,
      "name" TEXT,
      "date" TEXT NOT NULL,
      "time" TEXT NOT NULL,
      "total_price" REAL NOT NULL,
      "mode" TEXT NOT NULL,
      PRIMARY KEY("order_id" AUTOINCREMENT)
      );
      '''
    );
    await database.execute(
      ''' CREATE TABLE IF NOT EXISTS $orderItemsTable(
      "order_id" INTEGER NOT NULL,
      "product_name" TEXT NOT NULL,
      "size" TEXT,
      "qty" INTEGER NOT NULL,
      "price" REAL NOT NULL,
      FOREIGN KEY("order_id") REFERENCES $ordersTable("order_id")
      );
      '''
    );
    await database.execute(
      '''
      CREATE TABLE IF NOT EXISTS $employeeTable(
      "employee_id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "password" TEXT NOT NULL,
      PRIMARY KEY("employee_id" AUTOINCREMENT)
      );
      '''
    );
    await database.execute(
      '''
      CREATE TABLE IF NOT EXISTS $dtrTable(
      "employee_id" INTEGER NOT NULL,
      "time_in" TEXT NOT NULL,
      "time_out" TEXT NOT NULL,
      "date" TEXT NOT NULL,
      FOREIGN KEY("employee_id") REFERENCES employee("employee_id")
      );
      '''
    );
    await database.execute(
        '''
      INSERT INTO $icedTable(name, size, price, asset_path) VALUES(
      "Caramel Macchiato",
      "16oz",
      49.0,
      "assets/images/iced/CC.png"
      ),
      (
      "Caramel Macchiato",
      "12oz",
      39.0,
      "assets/images/iced/CC.png"
      ),
      ("Coffee Caramel",
      "16oz", 
      49.0,
      "assets/images/iced/CC.png"
      ),
      ("Dark Mocha",
      "12oz",
      39.0,
      "assets/images/iced/DM.png"
      ),
      ("Dark Mocha",
      "16oz",
      49.0,
      "assets/images/iced/DM.png"
      ),
      ("Espresso Latte",
      "16oz",
      49.0,
      "assets/images/iced/EL.png"
      ),
      ("French Vanilla",
      "12oz",
      39.0,
      "assets/images/iced/FV.png"
      ),
      ("French Vanilla",
      "16oz",
      49.0,
      "assets/images/iced/French Vanill.png"
      ),
      ("Hazelnut",
      "12oz",
      39.0,
      "assets/images/coffee-cup.png"
      ),
      ("Hazelnut",
      "16oz",
      49.0,
      "assets/images/coffee-cup.png"
      ),
      ("Salted Caramel",
      "12oz",
      39.0,
      "assets/images/iced/SC.png"
      ),
      ("Salted Caramel",
      "16oz",
      49.0,
      "assets/images/iced/SC.png"
      ),
      ("Spanish Latte",
      "12oz",
      39.0,
      "assets/images/iced/SL.png"
      ),
      ("Spanish Latte",
      "16oz",
      49.0,
      "assets/images/iced/SL.png"
      );
      '''
    );
    await database.execute(
        '''
      INSERT INTO $hotTable(name, price) VALUES
      ("Black Americano",
      49.0
      ),
      ("Caramel Macchiato (Hot)",
      59.0
      ),
      ("French Vanilla (Hot)",
      59.0
      ),
      ("Hazelnut (Hot)",
      59.0
      ),
      ("Salted Caramel (Hot)",
      59.0
      );
      '''
    );
    await database.execute(
      '''
      INSERT INTO $latteTable(name, size, price) VALUES
      ("Blueberry",
      "16oz",
      49.0
      ),
      ("Blueberry",
      "22oz",
      59.0
      ),
      ("Strawberry",
      "16oz",
      49.0
      ),
      ("Strawberry",
      "22oz",
      59.0
      ),
      ("Mango",
      "16oz",
      49.0
      ),
      ("Mango",
      "22oz",
      59.0
      ),
      ("Avocado",
      "16oz",
      49.0
      ),
      ("Avocado",
      "22oz",
      59.0
      ),
      ("Melon",
      "16oz",
      49.0
      ),
      ("Melon",
      "22oz",
      59.0
      ),
      ("Matcha Latte",
      "16oz",
      59.0
      ),
      ("Ube",
      "16oz",
      49.0
      ),
      ("Ube",
      "22oz",
      59.0
      ),
      ("Mixed Berries",
      "16oz",
      49.0
      ),
      ("Mixed Berries",
      "22oz",
      59.0
      );
      '''
    );
    await database.execute(
      '''
      INSERT INTO $crofflesTable(name, price)
      VALUES("Biscoff Plain",
      90.0
      ),
      ("Biscoff Supreme",
      145.0
      ),
      ("Classic Plain",
      80.0
      ),
      ("Nutella Plain",
      90.0
      ),
      ("Nutella Almond",
      95.0
      ),
      ("Nutella Almond & Cream",
      145.0
      ),
      ("Oreo Crumble",
      95.0
      ),
      ("Oreo Cookies & Cream",
      145.0
      ),
      ("Ham & Cheese",
      130.0
      ),
      ("Creamy Spinach",
      130.0
      );
      '''
    );
  }

  Future<List<IcedCoffee>> fetchIcedCoffee() async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
      '''
      SELECT DISTINCT name, status, asset_path FROM $icedTable
      ORDER BY name ASC
      '''
    );
    return tableInfo.map((info) => IcedCoffee.fromSQfliteDatabase(info)).toList();
  }
  Future<List<IcedCoffee>> fetchIcedCoffeeSpec(String name, String size) async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
        '''
      SELECT * FROM $icedTable
      WHERE name = ? AND size = ?
      ''', [name, size]
    );
    return tableInfo.map((info) => IcedCoffee.fromSQfliteDatabase(info)).toList();
  }

  Future<List<HotCoffee>> fetchHotCoffee() async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
      '''
      SELECT * FROM $hotTable
      ORDER BY name ASC
      '''
    );
    return tableInfo.map((info) => HotCoffee.fromSQfliteDatabase(info)).toList();
  }
  Future<List<HotCoffee>> fetchHotCoffeeSpec(String name) async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
        '''
      SELECT * FROM $hotTable
      WHERE name = ?
      ''', [name]
    );
    return tableInfo.map((info) => HotCoffee.fromSQfliteDatabase(info)).toList();
  }
  Future<List<Latte>> fetchLatte() async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
      '''
      SELECT DISTINCT name, status FROM $latteTable
      ORDER BY name ASC
      '''
    );
    return tableInfo.map((info) => Latte.fromSQfliteDatabase(info)).toList();
  }
  Future<List<Latte>> fetchLatteSpec(String name, String size) async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
        '''
      SELECT * FROM $latteTable
      WHERE name = ? AND size = ?
      ''', [name, size]
    );
    return tableInfo.map((info) => Latte.fromSQfliteDatabase(info)).toList();
  }
  Future<List<Croffles>> fetchCroffles() async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
      '''
      SELECT * FROM $crofflesTable
      ORDER BY name ASC
      '''
    );
    return tableInfo.map((info) => Croffles.fromSQfliteDatabase(info)).toList();
  }
  Future<List<Croffles>> fetchCrofflesSpec(String name) async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
        '''
      SELECT * FROM $crofflesTable
      WHERE name = ?
      ''', [name]
    );
    return tableInfo.map((info) => Croffles.fromSQfliteDatabase(info)).toList();
  }
  Future<void> insertOrder(String name, String date, String time, double total, String mode) async{
    final database = await DatabaseService().database;
    await database.rawInsert(
      """
      INSERT INTO orders(name, date, time, total_price, mode)
      VALUES(?, ?, ?, ?, ?)
      """, [name, date, time, total, mode]
    );
  }
  Future<List<Order>> getLatestOrderID() async{
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
      """
      SELECT * FROM $ordersTable
      ORDER BY order_id DESC
      LIMIT 1
      """
    );
    return tableInfo.map((info) => Order.fromSQfliteDatabase(info)).toList();
  }
  Future<void> insertOrderItem(int orderID, String name, String size, int qty, double price) async{
    final database = await DatabaseService().database;
    await database.rawInsert(
        """
      INSERT INTO $orderItemsTable(order_id, product_name, size, qty, price)
      VALUES(?, ?, ?, ?, ?)
      """, [orderID, name, size, qty, price]
    );
  }
  Future<List<Order>> getOrdersByDate(String date) async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
      """
      SELECT * FROM $ordersTable
      WHERE date = ?
      ORDER BY time DESC
      """, [date]
    );
    return tableInfo.map((info) => Order.fromSQfliteDatabase(info)).toList();
  }
  Future<List<OrderItems>> getOrdersItemsByID(int orderID) async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
      """
      SELECT * FROM $orderItemsTable
      WHERE order_id = ?
      """, [orderID]
    );
    return tableInfo.map((info) => OrderItems.fromSQfliteDatabase(info)).toList();
  }
  Future<int?> countCups() async {
    final database = await DatabaseService().database;
    final countCups = await database.rawQuery(
      """
      SELECT SUM(qty)
      FROM $orderItemsTable
      WHERE product_name IN
      (SELECT name FROM $icedTable)
      OR product_name IN
      (SELECT name FROM $hotTable)
      OR product_name IN
      (SELECT name FROM $latteTable)
      """
    );
    int? result = Sqflite.firstIntValue(countCups);
    return result;
  }
  Future<int?> countCroffles() async {
    final database = await DatabaseService().database;
    final countCups = await database.rawQuery(
        """
      SELECT SUM(qty)
      FROM $orderItemsTable
      WHERE product_name IN
      (SELECT name FROM $crofflesTable)
      """
    );
    int? result = Sqflite.firstIntValue(countCups);
    return result;
  }
  Future<List<OrderItems>> getIcedCoffeeCups() async {
    final database = await DatabaseService().database;
    final countIced = await database.rawQuery(
      """
      SELECT DISTINCT product_name, SUM(qty) AS qty
      FROM $orderItemsTable
      WHERE product_name IN
      (SELECT name FROM $icedTable)
      GROUP BY product_name
      ORDER BY qty DESC
      """
    );
    return countIced.map((info) => OrderItems.fromSQfliteDatabase(info)).toList();
  }
  Future<List<OrderItems>> getHotCoffeeCups() async {
    final database = await DatabaseService().database;
    final countIced = await database.rawQuery(
        """
      SELECT DISTINCT product_name, SUM(qty) AS qty
      FROM $orderItemsTable
      WHERE product_name IN
      (SELECT name FROM $hotTable)
      GROUP BY product_name
      ORDER BY qty DESC
      """
    );
    return countIced.map((info) => OrderItems.fromSQfliteDatabase(info)).toList();
  }
  Future<List<OrderItems>> getLatteCups() async {
    final database = await DatabaseService().database;
    final countIced = await database.rawQuery(
        """
      SELECT DISTINCT product_name, SUM(qty) AS qty
      FROM $orderItemsTable
      WHERE product_name IN
      (SELECT name FROM $latteTable)
      GROUP BY product_name
      ORDER BY qty DESC
      """
    );
    return countIced.map((info) => OrderItems.fromSQfliteDatabase(info)).toList();
  }
  Future<List<OrderItems>> getCrofflesSales() async {
    final database = await DatabaseService().database;
    final countIced = await database.rawQuery(
        """
      SELECT DISTINCT product_name, SUM(qty) AS qty
      FROM $orderItemsTable
      WHERE product_name IN
      (SELECT name FROM $crofflesTable)
      GROUP BY product_name
      ORDER BY qty DESC
      """
    );
    return countIced.map((info) => OrderItems.fromSQfliteDatabase(info)).toList();
  }
}