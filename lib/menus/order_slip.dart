import 'package:coffee_break_pos/database/classes/order.dart';
import 'package:coffee_break_pos/database/coffee_db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../custom_rect_tween.dart';
import 'globals.dart' as globals;

class OrderPaymentScreen extends StatefulWidget{
  const OrderPaymentScreen({
    super.key
  });

  @override
  _OrderPaymentState createState() => _OrderPaymentState();
}
class _OrderPaymentState extends State<OrderPaymentScreen>{
  int value = 1;
  String mode = "Cash";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Hero(
          tag: "Cart-Hero",
          createRectTween: (begin, end){
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              child: SizedBox(
                width: 500,
                height: 250,
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Total: ${globals.total}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                customRadioButton("Cash", 1),
                                const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                                customRadioButton("GCash", 2)
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 30)),
                            Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xf0967259),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  // Get current date and time
                                  DateTime now = DateTime.now();
                                  String formattedDate = DateFormat('MM/dd/yyyy').format(now);
                                  String formattedTime = DateFormat.jm().format(now);
                                  var coffeeDB = CoffeeDB();
                                  await coffeeDB.insertOrder(globals.customerName, formattedDate, formattedTime, globals.total, mode);
                                  List<Order> order = await coffeeDB.getLatestOrderID();
                                  int orderID = order[0].orderID;
                                  for(int i = 0; i < globals.orderList.length; i++){
                                    await coffeeDB.insertOrderItem(
                                        orderID,
                                        globals.orderList[i]["name"],
                                        globals.orderList[i]["size"],
                                        globals.orderList[i]["price"]
                                    );
                                  }
                                  
                                  Navigator.pop(context, false);
                                  setState(() {
                                    globals.total = 0;
                                    globals.orderList = [];
                                    globals.customerName = "";
                                  });
                                },
                                child: const Text(
                                  "DONE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                    )
                  ],
                ),
              )
          )
          ,
        ),
      ),
    );
  }
  Widget customRadioButton(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          value = index;
          mode = text;
        });
      },
      style: OutlinedButton.styleFrom(
          fixedSize: Size(150, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: value == index ? const Color(0xf0ece0d1) : Colors.white
      ),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}