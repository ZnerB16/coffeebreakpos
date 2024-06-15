import 'package:coffee_break_pos/database/classes/order_items.dart';
import 'package:coffee_break_pos/database/coffee_db.dart';
import 'package:coffee_break_pos/popups/success_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MoreInfoScreen extends StatefulWidget{
  final String name;
  final int orderID;
  final String modeOfPayment;

  const MoreInfoScreen({
    super.key,
    required this.name,
    required this.orderID,
    required this.modeOfPayment
  });
  @override
  _MoreInfoState createState() => _MoreInfoState();
}
class _MoreInfoState extends State<MoreInfoScreen>{
  List<Map<String, dynamic>> itemList = [];
  double total = 0.0;
  var coffeeDB = CoffeeDB();

  @override
  void initState(){
    super.initState();
    getOrderItems();
  }
  void getOrderItems() async {
    List<OrderItems> orderItems = await coffeeDB.getOrdersItemsByID(widget.orderID);
    setState(() {
      for(int i = 0; i < orderItems.length; i++){
        itemList.add(
            {
              "item": orderItems[i].productName,
              "size": orderItems[i].size,
              "qty": orderItems[i].qty,
              "price": orderItems[i].price
            }
        );
        total += itemList[i]["price"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 4,
        child: Container(
          width: 350,
          height: 450,
          decoration: const BoxDecoration(
            color: Colors.white
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Name: ${widget.name}",
                      style: const TextStyle(
                        fontSize: 16
                      ),
                    ),
                    const CloseButton(),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Mode of Payment: ${widget.modeOfPayment}",
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 15)),
                const Text(
                  "List of Orders:",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 15)),
                SizedBox(
                  width: 360,
                  height: 150,
                  child: Scrollbar(
                    thumbVisibility: true,
                    scrollbarOrientation: ScrollbarOrientation.right,
                    thickness: 5,
                    child: SingleChildScrollView(
                      child: DataTable(
                          dataRowMaxHeight: 50,
                          columnSpacing: 25,
                          dataRowMinHeight: 30,
                          horizontalMargin: 5,
                          border: TableBorder.all(),
                          columns:  const [
                        DataColumn(label: Center(
                          child: Text(
                              'Item',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                        ),
                        DataColumn(label: Center(
                          child: Text(
                              'Size',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                        ),
                        DataColumn(label: Center(
                          child: Text(
                              'Qty',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                        ),
                        DataColumn(label: Center(
                          child: Text(
                              'Price',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                        ),
                      ],
                          rows: itemList.map((e) =>
                            DataRow(
                                cells: [
                                  DataCell(Center(
                                    child: Text(e["item"],
                                      style: const TextStyle(fontSize: 16),),
                                  )),
                                  DataCell(Center(
                                    child: Text(e["size"],
                                      style: const TextStyle(fontSize: 16),),
                                  )),
                                  DataCell(Center(
                                    child: Text(e["qty"].toString(),
                                      style: const TextStyle(fontSize: 16),),
                                  )),
                                  DataCell(Center(
                                    child: Text(e["price"].toString(),
                                      style: const TextStyle(fontSize: 16),),
                                  )),
                                ]
                            )
                          ).toList()
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Text(
                    "Total: $total",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 5), // changes position of shadow
                        )]
                  ),
                  child: TextButton(
                      onPressed: () async {
                        await coffeeDB.deleteOrder(widget.orderID);
                        await alertDialog(context, "Order has been deleted");
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Delete Order",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}