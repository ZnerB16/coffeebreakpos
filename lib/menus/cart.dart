import 'package:coffee_break_pos/custom_rect_tween.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class Cart extends StatefulWidget{
  final String title;
  final String type;

  const Cart ({
    super.key,
    required this.title,
    required this.type
  });

  @override
  CartState createState() => CartState();
}
class CartState extends State<Cart>{

  int value = 1;
  int qty = 1;
  String currSize = "12oz";
  String size1 = "12oz";
  String size2 = "16oz";

  @override
  void initState(){
    super.initState();
    currSize = widget.type == "latte" ? "16oz" : "12oz";
  }

  void checkType(){
    if(widget.type == "latte"){

    }
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
            width: 800,
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
                                Align(
                                alignment: Alignment.topRight,
                                  widthFactor: 10.2,
                                  child: CloseButton(
                                    style: ButtonStyle(
                                      iconSize: MaterialStatePropertyAll(40)
                                    ),
                                  )
                              ),
                              ]
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 50)),
                        Image.asset('assets/images/coffee-cup.png'),
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
                          children: [
                            Visibility(
                              visible: widget.type != "croffles",
                                child: customRadioButton(widget.type == "latte" ? "16oz" : size1, 1)
                            ),
                            const Padding(padding: EdgeInsets.only(right: 15)),
                            Visibility(
                              visible: widget.type != "croffles",
                                child: customRadioButton(widget.type == "latte" ? "22oz" : size2, 2)
                            )
                          ],
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
                            onPressed: () {
                              setState(() {
                                globals.orderList.add({
                                  "name": widget.title,
                                  "size": currSize,
                                  "qty": qty,
                                  "price": 49.0,
                                });
                              });
                              Navigator.pop(context);
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
                    ),
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
    );
  }
}