import 'package:sqflite/sqflite.dart';
import 'database_service.dart';

class CoffeeDB{
  final icedTable = 'iced_coffee';
  final hotTable = 'hot_coffee';
  final latteTable = 'signature_latte';
  final crofflesTable = 'croffles';
  final ordersTable = 'orders';
  final orderItemsTable = 'order_items';

  Future<void>createTable(Database database)async {
    await database.execute(
      """ CREATE TABLE IF NOT EXISTS $icedTable(
      "iced_id" INTEGER NOT NULL,
      "asset_path" TEXT NOT NULL,
      "name" TEXT NOT NULL,
      "size" TEXT NOT NULL,
      "price" REAL NOT NULL,
      "status" BOOL NOT NULL,
      PRIMARY KEY("iced_id" AUTOINCREMENT)
      );
      """
    );
    await database.execute(
      """ CREATE TABLE IF NOT EXISTS $hotTable(
      "hot_id" INTEGER NOT NULL,
      "asset_path" TEXT NOT NULL,
      "name" TEXT NOT NULL,
      "price" REAL NOT NULL,
      "status" BOOL NOT NULL,
      PRIMARY KEY("hot_id" AUTOINCREMENT)
      );
      """
    );
    await database.execute(
      """ CREATE TABLE IF NOT EXISTS $latteTable(
      "latte_id" INTEGER NOT NULL,
      "asset_path" TEXT NOT NULL,
      "name" TEXT NOT NULL,
      "size" TEXT NOT NULL,
      "price" REAL NOT NULL,
      "status" BOOL NOT NULL,
      PRIMARY KEY("latte_id" AUTOINCREMENT)
      );
      """
    );
    await database.execute(
      """ CREATE TABLE IF NOT EXISTS $crofflesTable(
      "croffle_id" INTEGER NOT NULL,  
      "asset_path" TEXT NOT NULL,
      "name" TEXT NOT NULL,
      "price" REAL NOT NULL,
      "status" BOOL NOT NULL,
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
  }
}