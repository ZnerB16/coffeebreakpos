import 'package:coffee_break_pos/database/classes/order.dart';
import 'package:coffee_break_pos/database/coffee_db.dart';
import 'package:flutter/cupertino.dart';
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
  int value2 = 1;
  String mode2 = "No";
  double df = 0.0;
  var _controllerDF = TextEditingController();

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
                height: 400,
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Order Total: ${globals.total}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            const Text(
                                "Online Order?",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                customRadioButton2("No", 1),
                                const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                                customRadioButton2("Yes", 2)
                              ],
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
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            Visibility(
                              visible: mode == "GCash" && mode2 == "Yes",
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                      "DF: ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Container(
                                    width: 80,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(),
                                        color: const Color(0xf0EBEBEB)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: TextField(
                                        autocorrect: false,
                                        controller: _controllerDF,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'DF',
                                          hintStyle: TextStyle(fontSize: 16),
                                        ),
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                            fontSize: 16
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 20)),
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
                                  await coffeeDB.insertOrder(globals.customerName, formattedDate, formattedTime, globals.total, mode, mode2, df);
                                  List<Order> order = await coffeeDB.getLatestOrderID();
                                  int orderID = order[0].orderID;
                                  for(int i = 0; i < globals.orderList.length; i++){
                                    await coffeeDB.insertOrderItem(
                                        orderID,
                                        globals.orderList[i]["name"],
                                        globals.orderList[i]["size"],
                                        globals.orderList[i]["qty"],
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
          fixedSize: const Size(150, 50),
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
  Widget customRadioButton2(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          value2 = index;
          mode2 = text;
        });
      },
      style: OutlinedButton.styleFrom(
          fixedSize: const Size(75, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: value2 == index ? const Color(0xf0ece0d1) : Colors.white
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