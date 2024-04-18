import 'package:sqflite/sqflite.dart';
import 'database_service.dart';

class CoffeeDB{
  final icedTable = 'iced_coffee';
  final hotTable = 'hot_coffee';
  final latteTable = 'signature_latte';
  final crofflesTable = 'croffles';
  final ordersTable = 'orders';
  final orderItemsTable = 'order_items';
  final employeeTable = 'employee';
  final dtrTable = 'dtr';

  Future<void>createTable(Database database)async {
    await database.execute(
      """ CREATE TABLE IF NOT EXISTS $icedTable(
      "iced_id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "size" TEXT NOT NULL,
      "price" REAL NOT NULL,
      "status" BOOL DEFAULT 1 NOT NULL,
      PRIMARY KEY("iced_id" AUTOINCREMENT)
      );
      """
    );
    await insertProducts();
    await database.execute(
      """ CREATE TABLE IF NOT EXISTS $hotTable(
      "hot_id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "price" REAL NOT NULL,
      "status" BOOL DEFAULT 1 NOT NULL,
      PRIMARY KEY("hot_id" AUTOINCREMENT)
      );
      """
    );
    await database.execute(
      """ CREATE TABLE IF NOT EXISTS $latteTable(
      "latte_id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "size" TEXT NOT NULL,
      "price" REAL NOT NULL,
      "status" BOOL DEFAULT 1 NOT NULL,
      PRIMARY KEY("latte_id" AUTOINCREMENT)
      );
      """
    );
    await database.execute(
      """ CREATE TABLE IF NOT EXISTS $crofflesTable(
      "croffle_id" INTEGER NOT NULL,  
      "name" TEXT NOT NULL,
      "price" REAL NOT NULL,
      "status" BOOL DEFAULT 1 NOT NULL,
      PRIMARY KEY("croffle_id" AUTOINCREMENT)
      );
      """
    );
    await database.execute(
      """ CREATE TABLE IF NOT EXISTS $ordersTable(
      "order_id" INTEGER NOT NULL,
      "name" TEXT,
      "date" TEXT NOT NULL,
      "total_price" REAL NOT NULL,
      PRIMARY KEY("order_id" AUTOINCREMENT)
      );
      """
    );
    await database.execute(
      """ CREATE TABLE IF NOT EXISTS $orderItemsTable(
      "order_id" INTEGER NOT NULL,
      "product_name" TEXT NOT NULL,
      "size" TEXT,
      "price" REAL NOT NULL,
      FOREIGN KEY("order_id") REFERENCES orders("order_id")
      );
      """
    );
    await database.execute(
      """
      CREATE TABLE IF NOT EXISTS $employeeTable(
      "employee_id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "password" TEXT NOT NULL,
      PRIMARY KEY("employee_id" AUTOINCREMENT)
      )
      """
    );
    await database.execute(
      """
      CREATE TABLE IF NOT EXISTS $dtrTable(
      "employee_id" INTEGER NOT NULL,
      "time_in" TEXT NOT NULL,
      "time_out" TEXT NOT NULL,
      "date" TEXT NOT NULL,
      FOREIGN KEY("employee_id") REFERENCES employee("employee_id")
      )
      """
    );

  }
  Future<void> insertProducts() async {
    final database = await DatabaseService().database;
    await database.rawInsert(
      """
      INSERT OR IGNORE INTO $icedTable(name, size, price, status)
      VALUES("Caramel Macchiato",
      "16oz",
      49.0,
      ),
      ("Coffee Caramel",
      "16oz", 
      49.0,
      ),
      ("Dark Mocha",
      "12oz",
      39.0,
      ),
      ("Dark Mocha",
      "16oz",
      49.0,
      ),
      ("Espresso Latte",
      "16oz",
      49.0,
      ),
      ("French Vanilla",
      "12oz",
      39.0,
      ),
      ("French Vanilla",
      "16oz",
      49.0,
      ),
      ("Hazelnut",
      "12oz",
      39.0,
      ),
      ("Hazelnut",
      "16oz",
      49.0,
      ),
      ("Salted Caramel",
      "12oz",
      39.0,
      ),
      ("Salted Caramel",
      "16oz",
      49.0,
      ),
      ("Spanish Latte",
      "12oz",
      39.0,
      ),
      ("Spanish Latte",
      "16oz",
      49.0,
      )
      """
    );
  }
}