import 'package:coffee_break_pos/database/classes/add_ons.dart';
import 'package:coffee_break_pos/database/classes/others.dart';
import 'package:flutter/material.dart';

import '../custom_rect_tween.dart';
import '../database/coffee_db.dart';
import 'globals.dart' as globals;

class AddOnsHero extends StatefulWidget{

  const AddOnsHero ({super.key});

  @override
  _AddOnsState createState() => _AddOnsState();
}
class _AddOnsState extends State<AddOnsHero>{
  int qty = 1;
  int value = 1;
  String size = "";
  String currAdd = "Espresso";
  double price = 0.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 350,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  color: const Color(0xf0ece0d1),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                        children: [
                          Padding(padding: EdgeInsets.only(right: 30)),
                          Text(
                            "Add-ons",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Spacer(),
                          CloseButton(
                            style: ButtonStyle(
                                iconSize: MaterialStatePropertyAll(40)
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customRadioButton("Espresso", 1),
                        const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                        customRadioButton("Nata", 2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customRadioButton("Syrup", 3),
                        const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                        customRadioButton("Jam", 4),
                      ],
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                qtyButton(),
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
                        offset: const Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () async {
                      await getAddOnDetails(currAdd);
                      setState(() {
                        globals.orderList.add(
                          {
                            "name": currAdd,
                            "size": size,
                            "qty": qty,
                            "price": price
                          }
                        );
                      });
                      Navigator.pop(context);
                    }
                    ,
                    child: const Text(
                      "DONE",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Spacer()
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget customRadioButton(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          value = index;
          currAdd = text;
        });
      },
      style: OutlinedButton.styleFrom(
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
  Widget qtyButton(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xf0967259),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  if(qty > 1){
                    qty--;
                  }
                });
              },
              icon: Image.asset("assets/images/minus-sign.png"),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
          Text(
            "$qty",
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xf0967259),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  qty++;
                });
              },
              icon: Image.asset("assets/images/plus.png"),
            ),
          )
        ]
    );
  }
  Future<void> getAddOnDetails(String name) async{
    var coffeeDB = CoffeeDB();
    List<AddOns> addOnList = await coffeeDB.fetchAddOnSpec(name);
    setState(() {
      price = qty * addOnList[0].price;
      size = addOnList[0].size;
    });
  }
}