import 'package:coffee_break_pos/database/classes/croffles.dart';
import 'package:coffee_break_pos/database/classes/dtr.dart';
import 'package:coffee_break_pos/database/classes/employee.dart';
import 'package:coffee_break_pos/database/classes/hot_coffee.dart';
import 'package:coffee_break_pos/database/classes/iced_coffee.dart';
import 'package:coffee_break_pos/database/classes/latte.dart';
import 'package:sqflite/sqflite.dart';
import 'classes/add_ons.dart';
import 'classes/order.dart';
import 'classes/order_items.dart';
import 'classes/others.dart';
import 'database_service.dart';

class CoffeeDB {
  final icedTable = 'iced_coffee';
  final hotTable = 'hot_coffee';
  final addonsTable = 'add_ons';
  final latteTable = 'latte';
  final crofflesTable = 'croffles';
  final ordersTable = 'orders';
  final orderItemsTable = 'order_items';
  final employeeTable = 'employee';
  final dtrTable = 'dtr';
  final othersTable = 'other_items';
  final inventoryTable = 'inventory';

  Future<void> createTable(Database database) async {
    await database.execute(
      ''' CREATE TABLE IF NOT EXISTS $addonsTable(
      "add_on_id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "size" TEXT NOT NULL,
      "price" REAL NOT NULL,
      PRIMARY KEY("add_on_id" AUTOINCREMENT)
      );
      '''
    );
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
      ''' CREATE TABLE IF NOT EXISTS $othersTable(
      "product_id" INTEGER NOT NULL,  
      "name" TEXT NOT NULL,
      "size" TEXT DEFAULT "",
      "price" REAL NOT NULL,
      "status" BOOL DEFAULT 1 NOT NULL,
      "asset_path" TEXT,
      PRIMARY KEY("product_id" AUTOINCREMENT)
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
      "is_online" TEXT NOT NULL,
      "df" REAL NOT NULL,
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
      "address" TEXT NOT NULL,
      "birthdate" TEXT NOT NULL,
      "password" TEXT NOT NULL,
      PRIMARY KEY("employee_id" AUTOINCREMENT)
      );
      '''
    );
    await database.execute(
        '''
      CREATE TABLE IF NOT EXISTS $dtrTable(
      "employee_id" INTEGER NOT NULL,
      "time_in" TEXT,
      "time_out" TEXT,
      "date" TEXT NOT NULL,
      FOREIGN KEY("employee_id") REFERENCES employee("employee_id")
      );
      '''
    );
    await database.execute(
      '''
      CREATE TABLE IF NOT EXISTS $inventoryTable(
      "inventory_id" INTEGER NOT NULL,
      "inventory_date" TEXT NOT NULL,
      "milk" INTEGER,
      "blueberry" INTEGER,
      "strawberry" INTEGER,
      "mango" INTEGER,
      "nata" INTEGER,
      "condense" INTEGER,
      "caramel_syrup" INTEGER,
      "chocolate_syrup" INTEGER,
      "straw_coffee_takeout" INTEGER,
      "straw_latte" INTEGER,
      "straw_coffee_dinein" INTEGER,
      "spork" INTEGER,
      "croffle_takeout" INTEGER,
      "cellophane_1cup" INTEGER,
      "cellophane_2cups" INTEGER,
      "cellophane_croffles" INTEGER,
      PRIMARY KEY("inventory_id" AUTOINCREMENT) 
      );
      '''
    );

    await database.execute(
      '''
      INSERT INTO $addonsTable(name, size, price)
      VALUES
      ("Espresso", "40ml", 10.0),
      ("Nata", "1scoop", 5.0),
      ("Syrup", "10ml", 10.0),
      ("Jam", "1scoop", 10.0)
      '''
    );
    await database.execute(
        '''
      INSERT INTO $icedTable(name, size, price, asset_path) VALUES(
      "Black Americano",
      "12oz",
      49.0,
      "assets/images/coffee-cup.png"
      ),
      (
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
      "assets/images/iced/French Vanill.png"
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
      ("Black Americano (Hot)",
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
      INSERT INTO $latteTable(name, size, price, asset_path) VALUES
      ("Blueberry",
      "16oz",
      49.0,
      "assets/images/latte/Blueberry.png"
      ),
      ("Blueberry",
      "22oz",
      59.0,
      "assets/images/latte/Blueberry.png"
      ),
      ("Buko Pandan",
      "16oz",
      49.0,
      "assets/images/latte/Buko Pandan.png"
      ),
      ("Buko Pandan",
      "22oz",
      59.0,
      "assets/images/latte/Buko Pandan.png"
      ),
      ("Strawberry",
      "16oz",
      49.0,
      "assets/images/latte/Strawberry.png"
      ),
      ("Strawberry",
      "22oz",
      59.0,
      "assets/images/latte/Strawberry.png"
      ),
      ("Mango",
      "16oz",
      49.0,
      "assets/images/latte/Mango.png"
      ),
      ("Mango",
      "22oz",
      59.0,
      "assets/images/latte/Mango.png"
      ),
      ("Avocado",
      "16oz",
      49.0,
      "assets/images/latte/Avocado.png"
      ),
      ("Avocado",
      "22oz",
      59.0,
      "assets/images/latte/Avocado.png"
      ),
      ("Melon",
      "16oz",
      49.0,
      "assets/images/latte/Melon.png"
      ),
      ("Melon",
      "22oz",
      59.0,
      "assets/images/latte/Melon.png"
      ),
      ("Matcha Latte",
      "16oz",
      59.0,
      "assets/images/coffee-cup.png"
      ),
      ("Matcha Latte",
      "22oz",
      69.0,
      "assets/images/coffee-cup.png"
      ),
      ("Ube",
      "16oz",
      49.0,
      "assets/images/latte/Ube.png"
      ),
      ("Ube",
      "22oz",
      59.0,
      "assets/images/latte/Ube.png"
      ),
      ("Mixed Berries",
      "16oz",
      49.0,
      "assets/images/latte/Mixed Berries.png"
      ),
      ("Mixed Berries",
      "22oz",
      59.0,
      "assets/images/latte/Mixed Berries.png"
      );
      '''
    );
    await database.execute(
        '''
      INSERT INTO $crofflesTable(name, price)
      VALUES("Biscoff Plain",
      110.0
      ),
      ("Biscoff Supreme",
      145.0
      ),
      ("Classic Plain",
      90.0
      ),
      ("Nutella Plain",
      110.0
      ),
      ("Nutella Almond",
      115.0
      ),
      ("Nutella Almond & Cream",
      145.0
      ),
      ("Oreo Crumble",
      115.0
      ),
      ("Oreo Cookies & Cream",
      145.0
      ),
      ("Ham & Cheese",
      130.0
      ),
      ("Creamy Spinach",
      130.0
      ),
      ("White Chocolate Almond",
      115.0
      );
      '''
    );
    await database.execute(
      '''
      INSERT INTO $othersTable(name, price)
      VALUES(
      "Cookies Choco",
      25.0
      ),
      (
      "Cookies Matcha",
      25.0
      ),
      (
      "Cookies Oats",
      25.0
      ),
      (
      "Cookies Red Velvet",
      25.0
      )
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
    return tableInfo.map((info) => IcedCoffee.fromSQfliteDatabase(info))
        .toList();
  }
  Future<List<IcedCoffee>> fetchIcedCoffeeSpec(String name, String size) async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
        '''
      SELECT * FROM $icedTable
      WHERE name = ? AND size = ?
      ''', [name, size]
    );
    return tableInfo.map((info) => IcedCoffee.fromSQfliteDatabase(info))
        .toList();
  }

  Future<List<IcedCoffee>> fetchIcedCoffeeSpecEdit(String name) async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
        '''
      SELECT * FROM $icedTable
      WHERE name = ?
      ''', [name]
    );
    return tableInfo.map((info) => IcedCoffee.fromSQfliteDatabase(info))
        .toList();
  }
  Future<List<IcedCoffee>> fetchIcedCoffeeSpecSize(String name, String size) async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
        '''
      SELECT * FROM $icedTable
      WHERE name = ? AND size = ?
      ''', [name, size]
    );
    return tableInfo.map((info) => IcedCoffee.fromSQfliteDatabase(info))
        .toList();
  }

  Future<List<HotCoffee>> fetchHotCoffee() async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
        '''
      SELECT * FROM $hotTable
      ORDER BY name ASC
      '''
    );
    return tableInfo.map((info) => HotCoffee.fromSQfliteDatabase(info))
        .toList();
  }

  Future<List<HotCoffee>> fetchHotCoffeeSpec(String name) async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
        '''
      SELECT * FROM $hotTable
      WHERE name = ?
      ''', [name]
    );
    return tableInfo.map((info) => HotCoffee.fromSQfliteDatabase(info))
        .toList();
  }
  Future<List<Latte>> fetchLatteSpecSize(String name, String size) async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
        '''
      SELECT * FROM $latteTable
      WHERE name = ? AND size = ?
      ''', [name, size]
    );
    return tableInfo.map((info) => Latte.fromSQfliteDatabase(info))
        .toList();
  }
  Future<List<AddOns>> fetchAddOnSpec(String name) async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
        '''
      SELECT * FROM $addonsTable
      WHERE name = ?
      ''', [name]
    );
    return tableInfo.map((info) => AddOns.fromSQfliteDatabase(info))
        .toList();
  }

  Future<List<Latte>> fetchLatte() async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
        '''
      SELECT DISTINCT name, status, asset_path FROM $latteTable
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

  Future<List<Latte>> fetchLatteSpecEdit(String name) async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
        '''
      SELECT * FROM $latteTable
      WHERE name = ?
      ''', [name]
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
  Future<List<Others>> fetchOthersSpec(String name) async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
        '''
      SELECT * FROM $othersTable
      WHERE name = ?
      ''', [name]
    );
    return tableInfo.map((info) => Others.fromSQfliteDatabase(info)).toList();
  }

  Future<void> insertOrder(String name, String date, String time, double total,
      String mode, String isOnline, double df) async {
    final database = await DatabaseService().database;
    await database.rawInsert(
        """
      INSERT INTO orders(name, date, time, total_price, mode, is_online, df)
      VALUES(?, ?, ?, ?, ?, ?, ?)
      """, [name, date, time, total, mode, isOnline, df]
    );
  }

  Future<List<Order>> getLatestOrderID() async {
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

  Future<void> insertOrderItem(int orderID, String name, String size, int qty,
      double price) async {
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
      ORDER BY order_id DESC
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
    return tableInfo.map((info) => OrderItems.fromSQfliteDatabase(info))
        .toList();
  }

  Future<int?> countCups(String date) async {
    final database = await DatabaseService().database;
    final countCups = await database.rawQuery(
        """
      SELECT SUM(qty)
      FROM $orderItemsTable
      WHERE order_id IN
      (SELECT order_id FROM $ordersTable WHERE date = ?)
      AND (product_name IN
      (SELECT name FROM $icedTable)
      OR product_name IN
      (SELECT name FROM $hotTable)
      OR product_name IN
      (SELECT name FROM $latteTable))
      
      """, [date]
    );
    int? result = Sqflite.firstIntValue(countCups);
    return result;
  }

  Future<int?> countCroffles(String date) async {
    final database = await DatabaseService().database;
    final countCups = await database.rawQuery(
        """
      SELECT SUM(qty)
      FROM $orderItemsTable
      WHERE product_name IN
      (SELECT name FROM $crofflesTable)
      AND order_id IN
      (SELECT order_id FROM $ordersTable WHERE date = ?)
      """, [date]
    );
    int? result = Sqflite.firstIntValue(countCups);
    return result;
  }

  Future<List<OrderItems>> getIcedCoffeeCups(String date) async {
    final database = await DatabaseService().database;
    final countIced = await database.rawQuery(
        """
      SELECT DISTINCT product_name, SUM(qty) AS qty
      FROM $orderItemsTable
      WHERE product_name IN
      (SELECT name FROM $icedTable)
      AND order_id IN
      (SELECT order_id FROM $ordersTable WHERE date = ?)
      GROUP BY product_name
      ORDER BY qty DESC
      """, [date]
    );
    return countIced.map((info) => OrderItems.fromSQfliteDatabase(info))
        .toList();
  }

  Future<List<OrderItems>> getHotCoffeeCups(String date) async {
    final database = await DatabaseService().database;
    final countIced = await database.rawQuery(
        """
      SELECT DISTINCT product_name, SUM(qty) AS qty
      FROM $orderItemsTable
      WHERE product_name IN
      (SELECT name FROM $hotTable)
      AND order_id IN
      (SELECT order_id FROM $ordersTable WHERE date = ?)
      GROUP BY product_name
      ORDER BY qty DESC
      """, [date]
    );
    return countIced.map((info) => OrderItems.fromSQfliteDatabase(info))
        .toList();
  }
  Future<List<OrderItems>> getLatteCups(String date) async {
    final database = await DatabaseService().database;
    final countIced = await database.rawQuery(
        """
      SELECT DISTINCT product_name, SUM(qty) AS qty
      FROM $orderItemsTable
      WHERE product_name IN
      (SELECT name FROM $latteTable)
      AND order_id IN
      (SELECT order_id FROM $ordersTable WHERE date = ?)
      GROUP BY product_name
      ORDER BY qty DESC
      """, [date]
    );
    return countIced.map((info) => OrderItems.fromSQfliteDatabase(info))
        .toList();
  }

  Future<List<OrderItems>> getCrofflesSales(String date) async {
    final database = await DatabaseService().database;
    final countIced = await database.rawQuery(
        """
      SELECT DISTINCT product_name, SUM(qty) AS qty
      FROM $orderItemsTable
      WHERE product_name IN
      (SELECT name FROM $crofflesTable)
      AND order_id IN
      (SELECT order_id FROM $ordersTable WHERE date = ?)
      GROUP BY product_name
      ORDER BY qty DESC
      """, [date]
    );
    return countIced.map((info) => OrderItems.fromSQfliteDatabase(info))
        .toList();
  }
  Future<List<OrderItems>> getOthersSales(String date) async {
    final database = await DatabaseService().database;
    final countOthers = await database.rawQuery(
        """
      SELECT DISTINCT product_name, SUM(qty) AS qty
      FROM $orderItemsTable
      WHERE product_name IN
      (SELECT name FROM $othersTable)
      AND order_id IN
      (SELECT order_id FROM $ordersTable WHERE date = ?)
      GROUP BY product_name
      ORDER BY qty DESC
      """, [date]
    );
    return countOthers.map((info) => OrderItems.fromSQfliteDatabase(info))
        .toList();
  }
  Future<List<OrderItems>> getAddOnSales(String date) async {
    final database = await DatabaseService().database;
    final countIced = await database.rawQuery(
        """
      SELECT DISTINCT product_name, SUM(qty) AS qty
      FROM $orderItemsTable
      WHERE product_name IN
      (SELECT name FROM $addonsTable)
      AND order_id IN
      (SELECT order_id FROM $ordersTable WHERE date = ?)
      GROUP BY product_name
      ORDER BY qty DESC
      """, [date]
    );
    return countIced.map((info) => OrderItems.fromSQfliteDatabase(info))
        .toList();
  }

  Future<void> insertEmployee(String name, String password, String address,
      String birthdate) async {
    final database = await DatabaseService().database;
    await database.rawInsert(
        """
      INSERT INTO $employeeTable(name, password, address, birthdate)
      VALUES (?, ?, ?, ?)
      """, [name, password, address, birthdate]
    );
  }

  Future<List<Employee>> getLatestEmployee() async {
    final database = await DatabaseService().database;
    final result = await database.rawQuery(
        """
      SELECT * FROM $employeeTable
      ORDER BY employee_id DESC
      LIMIT 1
      """
    );
    return result.map((info) => Employee.fromSQfliteDatabase(info)).toList();
  }

  Future<List<Employee>> getEmployeeFromID(int employeeID) async {
    final database = await DatabaseService().database;
    final result = await database.rawQuery(
        """
      SELECT * FROM $employeeTable
      WHERE employee_id = ?
      """, [employeeID]
    );
    return result.map((info) => Employee.fromSQfliteDatabase(info)).toList();
  }

  Future<List<DTR>> getEmployeeDetailsFromID(int employeeID) async {
    final database = await DatabaseService().database;
    final result = await database.rawQuery(
        """
      SELECT * FROM $dtrTable
      WHERE employee_id = ?
      """, [employeeID]
    );
    return result.map((info) => DTR.fromSQfliteDatabase(info)).toList();
  }

  Future<List<Employee>> getEmployees() async {
    final database = await DatabaseService().database;
    final result = await database.rawQuery(
        """
      SELECT * FROM $employeeTable
      """
    );
    return result.map((info) => Employee.fromSQfliteDatabase(info)).toList();
  }

  Future<List<DTR>> getLatestDateEmployeeFromID(int employeeID) async {
    final database = await DatabaseService().database;
    final result = await database.rawQuery(
        """
      SELECT * FROM $dtrTable
      WHERE employee_id = ?
      ORDER BY date DESC
      LIMIT 1
      """, [employeeID]
    );
    return result.map((info) => DTR.fromSQfliteDatabase(info)).toList();
  }

  Future<void> insertEmployeeDetailsTimeIn(int employeeID, String date, String timeIn) async{
    final database = await DatabaseService().database;
    await database.rawInsert(
      """
      INSERT INTO $dtrTable(employee_id, date, time_in)
      VALUES(?, ?, ?)
      """, [employeeID, date, timeIn]
    );
  }

  Future<void> updateEmployeeDetailsTimeOut(int employeeID, String date, String timeOut) async{
    final database = await DatabaseService().database;
    await database.rawInsert(
      """
      UPDATE $dtrTable
      SET time_out = ?
      WHERE employee_id = ? AND date = ?
      """, [timeOut, employeeID, date]
    );
  }

  Future<List<Order>> getSalesDay() async{
    final database = await DatabaseService().database;
    final result = await database.rawQuery(
      """
      SELECT date, SUM(total_price) AS total_price
      FROM $ordersTable
      GROUP BY date
      ORDER BY date DESC
      LIMIT 10
      """
    );
    return result.map((info) => Order.fromSQfliteDatabase(info)).toList();
  }

  Future<List<Order>> getSalesForChart() async{
    final database = await DatabaseService().database;
    final result = await database.rawQuery(
        """
      SELECT date, SUM(total_price) AS total_price
      FROM $ordersTable
      GROUP BY date
      ORDER BY date DESC
      LIMIT 7
      """
    );
    return result.map((info) => Order.fromSQfliteDatabase(info)).toList();
  }

  Future<List<DTR>> getDTR() async {
    final database = await DatabaseService().database;
    final result = await database.rawQuery(
      """
      SELECT *
      FROM $dtrTable
      JOIN $employeeTable
      ON $employeeTable.employee_id = $dtrTable.employee_id
      ORDER BY $dtrTable.date DESC
      """
    );
    return result.map((info) => DTR.joinedData(info)).toList();
  }

  Future<void> updateItemStatus(String name, String type, int status) async {
    final database = await DatabaseService().database;
    if(type == "iced"){
      await database.rawQuery(
        """
        UPDATE $icedTable
        SET status = ?
        WHERE name = ?
        """, [status, name]
      );
    }
    else if(type == "hot"){
      await database.rawQuery(
        """
        UPDATE $hotTable
        SET status = ?
        WHERE name = ?
        """, [status, name]
      );
    }
    else if(type == "latte"){
      await database.rawQuery(
        """
        UPDATE $latteTable
        SET status = ?
        WHERE name = ?
        """, [status, name]
      );
    }
    else if(type == "others"){
      await database.rawQuery(
        """
        UPDATE $othersTable
        SET status = ?
        WHERE name = ?
        """, [status, name]
      );
    }
    else{
      await database.rawQuery(
        """
        UPDATE $crofflesTable
        SET status = ?
        WHERE name = ?
        """, [status, name]
      );
    }
  }

  Future<List<Others>> fetchOthers() async {
    final database = await DatabaseService().database;
    final tableInfo = await database.rawQuery(
        '''
      SELECT DISTINCT name, status, asset_path FROM $othersTable
      ORDER BY name ASC
      '''
    );
    return tableInfo.map((info) => Others.fromSQfliteDatabase(info))
        .toList();
  }
  Future<void> deleteOrder(int orderID) async {
    final database = await DatabaseService().database;
    await database.rawQuery(
        '''
      DELETE FROM $orderItemsTable
      WHERE order_id = ?
      ''', [orderID]
    );
    await database.rawQuery(
        '''
      DELETE FROM $ordersTable
      WHERE order_id = ?
      ''', [orderID]
    );
  }
  Future<List<OrderItems>> getTotal12oz(String date) async {
    final database = await DatabaseService().database;
    final result = await database.rawQuery(
      '''
      SELECT SUM(price) AS price
      FROM $orderItemsTable
      WHERE size = '12oz' 
      AND order_id
      IN (SELECT order_id FROM $ordersTable WHERE date = ?)
      ''', [date]
    );
    return result.map((info) => OrderItems.fromSQfliteDatabase(info))
        .toList();
  }
  Future<List<OrderItems>> getTotal16oz(String date) async {
    final database = await DatabaseService().database;
    final result = await database.rawQuery(
        '''
      SELECT SUM(price) AS price
      FROM $orderItemsTable
      WHERE size = '16oz'
      AND order_id
      IN (SELECT order_id FROM $ordersTable WHERE date = ?)
      ''', [date]
    );
    return result.map((info) => OrderItems.fromSQfliteDatabase(info))
        .toList();
  }
  Future<List<OrderItems>> getTotal22oz(String date) async {
    final database = await DatabaseService().database;
    final result = await database.rawQuery(
        '''
      SELECT SUM(price) AS price
      FROM $orderItemsTable
      WHERE size = '22oz'
      AND order_id
      IN (SELECT order_id FROM $ordersTable WHERE date = ?)
      ''', [date]
    );
    return result.map((info) => OrderItems.fromSQfliteDatabase(info))
        .toList();
  }
  Future<List<OrderItems>> getTotalCroffles(String date) async {
    final database = await DatabaseService().database;
    final result = await database.rawQuery(
        '''
      SELECT SUM(price) AS price
      FROM $orderItemsTable
      WHERE product_name
      IN (SELECT name FROM $crofflesTable)
      AND order_id
      IN (SELECT order_id FROM $ordersTable WHERE date = ?)
      ''', [date]
    );
    return result.map((info) => OrderItems.fromSQfliteDatabase(info))
        .toList();
  }
  Future<List<OrderItems>> getTotalCookies(String date) async {
    final database = await DatabaseService().database;
    final result = await database.rawQuery(
        '''
      SELECT SUM(price) AS price
      FROM $orderItemsTable
      WHERE product_name
      IN (SELECT name FROM $othersTable)
      AND order_id
      IN (SELECT order_id FROM $ordersTable WHERE date = ?)
      ''', [date]
    );
    return result.map((info) => OrderItems.fromSQfliteDatabase(info))
        .toList();
  }
  Future<List<OrderItems>> getTotalAddons(String date) async {
    final database = await DatabaseService().database;
    final result = await database.rawQuery(
        '''
      SELECT SUM(price) AS price
      FROM $orderItemsTable
      WHERE product_name
      IN (SELECT name FROM $addonsTable)
      AND order_id
      IN (SELECT order_id FROM $ordersTable WHERE date = ?)
      ''', [date]
    );
    return result.map((info) => OrderItems.fromSQfliteDatabase(info))
        .toList();
  }
  Future<void> updateIcedCoffee(String name, String size, double price, int status, String oldName) async {
    final database = await DatabaseService().database;
    await database.rawQuery(
        '''
      UPDATE $icedTable
      SET name = ?,
          price = ?,
          status = ?
      WHERE name = ? AND size = ?
      ''', [name, price, status, oldName, size]
    );
  }
  Future<void> updateHotCoffee(String name, double price, int status, String oldName) async {
    final database = await DatabaseService().database;
    await database.rawQuery(
        '''
      UPDATE $hotTable
      SET name = ?,
          price = ?,
          status = ?
      WHERE name = ?
      ''', [name, price, status, oldName]
    );
  }
  Future<void> updateLatte(String name, String size, double price, int status, String oldName) async {
    final database = await DatabaseService().database;
    await database.rawQuery(
        '''
      UPDATE $latteTable
      SET name = ?,
          price = ?,
          status = ?
      WHERE name = ? AND size = ?
      ''', [name, price, status, oldName, size]
    );
  }
  Future<void> updateCroffles(String name, double price, int status, String oldName) async {
    final database = await DatabaseService().database;
    await database.rawQuery(
        '''
      UPDATE $crofflesTable
      SET name = ?,
          price = ?,
          status = ?
      WHERE name = ?
      ''', [name, price, status, oldName]
    );
  }
  Future<void> updateOthers(String name, double price, int status, String oldName) async {
    final database = await DatabaseService().database;
    await database.rawQuery(
        '''
      UPDATE $othersTable
      SET name = ?,
          price = ?,
          status = ?
      WHERE name = ?
      ''', [name, price, status, oldName]
    );
  }
  Future<void> addIcedCoffee(String name, String size, double price) async {
    final database = await DatabaseService().database;
    await database.rawQuery(
      '''
      INSERT INTO $icedTable(name, size, price)
      VALUES(
      ?,
      ?,
      ?
      )
      ''', [name, size, price]
    );
  }
  Future<void> addHotCoffee(String name, double price) async {
    final database = await DatabaseService().database;
    await database.rawQuery(
        '''
      INSERT INTO $hotTable(name, price)
      VALUES(
      ?,
      ?
      )
      ''', [name, price]
    );
  }
  Future<void> addLatte(String name, String size, double price) async {
    final database = await DatabaseService().database;
    await database.rawQuery(
        '''
      INSERT INTO $latteTable(name, size, price)
      VALUES(
      ?,
      ?,
      ?
      )
      ''', [name, size, price]
    );
  }
  Future<void> deleteItem(String name, String size, String type) async {
    final database = await DatabaseService().database;
    if(type == "iced"){
      await database.rawQuery(
      '''
      DELETE FROM $icedTable
      WHERE name = ? AND size = ?
      ''', [name, size]
      );
    }
    else if(type == "hot"){
      await database.rawQuery(
      '''
      DELETE FROM $hotTable
      WHERE name = ?
      ''', [name]
      );
    }
    else if(type == "latte"){
      await database.rawQuery(
      '''
      DELETE FROM $latteTable
      WHERE name = ? AND size = ?
      ''', [name, size]
      );
    }
    else if(type == "croffles"){
      await database.rawQuery(
      '''
      DELETE FROM $crofflesTable
      WHERE name = ?
      ''', [name]
      );
    }
    else if(type == "others"){
      await database.rawQuery(
      '''
      DELETE FROM $othersTable
      WHERE name = ?
      ''', [name]
      );
    }
  }
}