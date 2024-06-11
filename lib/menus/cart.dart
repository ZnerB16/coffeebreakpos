import 'dart:async';

import 'package:coffee_break_pos/custom_rect_tween.dart';
import 'package:coffee_break_pos/database/classes/croffles.dart';
import 'package:coffee_break_pos/database/classes/hot_coffee.dart';
import 'package:coffee_break_pos/database/classes/iced_coffee.dart';
import 'package:coffee_break_pos/database/classes/latte.dart';
import 'package:coffee_break_pos/database/coffee_db.dart';
import 'package:flutter/material.dart';
import '../database/classes/others.dart';
import 'globals.dart' as globals;

class Cart extends StatefulWidget{
  final String title;
  final String type;
  final String assetPath;

  const Cart ({
    super.key,
    required this.title,
    required this.type,
    required this.assetPath
  });

  @override
  CartState createState() => CartState();
}
class CartState extends State<Cart>{

  int value = 0;
  int qty = 1;
  double price = 0.0;
  String currSize = "";
  List<String> sizes = [];
  var coffeeDB = CoffeeDB();

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getSizes();
      if(sizes.isNotEmpty){
        currSize = sizes[0];
      }
    });

  }

  Future<void> getSizes() async {
    List<IcedCoffee> icedList = await coffeeDB.fetchIcedCoffeeSpecEdit(widget.title);
    List<Latte> latteList = await coffeeDB.fetchLatteSpecEdit(widget.title);
    List<Others> othersList = await coffeeDB.fetchOthersSpec(widget.title);

    setState(() {
      if(widget.type == "iced"){
        for(int i = 0; i < icedList.length; i++){
          sizes.add(icedList[i].size);
        }
      }
      else if(widget.type == "hot"){
        sizes.add("12oz");
      }
      else if(widget.type == "latte"){
        for(int i = 0; i < latteList.length; i++){
          sizes.add(latteList[i].size);
        }
      }
      else if(widget.type == "others"){
        for(int i = 0; i < othersList.length; i++){
          sizes.add(othersList[i].size!);
        }
      }

    });
  }

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
            width: 600,
            height: 500,
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
                                  "Add to Order",
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
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        Image.asset(widget.assetPath),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                          children: sizes.asMap().map((i, element){
                            return MapEntry(i, customRadioButton(element, i));
                          }).values.toList()
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
                              await getProductDetails(widget.title, widget.title != "Espresso Latte" && widget.title != "Coffee Caramel" ? currSize : "16oz");
                              setState(() {

                                globals.orderList.add({
                                  "name": widget.title,
                                  "size": currSize,
                                  "qty": qty,
                                  "price": price,
                                });
                              });
                              globals.computeTotal();
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

                      ],
                    ),
                  )
                ],
              ),
            )
            ),
          ),
        ),
    );
  }
  Widget customRadioButton(String text, int index) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {
            setState(() {
              value = index;
              currSize = text;
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
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 5))
      ],
    );
  }
  Future<void> getProductDetails(String name, String size) async{
    var coffeeDB = CoffeeDB();

    if(widget.type == "iced"){
      List<IcedCoffee> icedList = await coffeeDB.fetchIcedCoffeeSpec(name, size);
      setState(() {
        price = icedList[0].price * qty;
      });
    }
    else if(widget.type == "hot"){
      List<HotCoffee> hotList = await coffeeDB.fetchHotCoffeeSpec(name);
      setState(() {
        price = hotList[0].price * qty;
      });
    }
    else if(widget.type == "latte"){
      List<Latte> latteList = await coffeeDB.fetchLatteSpec(name, size);
      setState(() {
        price = latteList[0].price * qty;
      });
    }
    else if(widget.type == "croffles"){
      List<Croffles> croffleList = await coffeeDB.fetchCrofflesSpec(name);
      setState(() {
        price = croffleList[0].price * qty;
      });
    }
    else if(widget.type == "others"){
      List<Others> otherList = await coffeeDB.fetchOthersSpec(name);
      setState(() {
        price = otherList[0].price * qty;
      });
    }
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
}