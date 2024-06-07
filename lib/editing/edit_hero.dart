import 'package:coffee_break_pos/database/classes/croffles.dart';
import 'package:coffee_break_pos/database/classes/hot_coffee.dart';
import 'package:coffee_break_pos/database/classes/iced_coffee.dart';
import 'package:coffee_break_pos/database/classes/latte.dart';
import 'package:flutter/material.dart';

import '../custom_rect_tween.dart';
import '../database/classes/others.dart';
import '../database/coffee_db.dart';
import '../popups/success_popup.dart';

class EditHero extends StatefulWidget{
  final String type;
  final String assetPath;
  final String title;

  const EditHero({
    super.key,
    required this.type,
    required this.assetPath,
    required this.title
  });
  @override
  _EditState createState() => _EditState();
}
class _EditState extends State<EditHero>{

  int value = 1;
  var coffeeDB = CoffeeDB();

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      value = await setDefaultValue();
    });
  }

  Future<int> setDefaultValue() async {
    int status = 0;
    List<IcedCoffee> icedList = await coffeeDB.fetchIcedCoffeeSpecEdit(widget.title);
    List<HotCoffee> hotList = await coffeeDB.fetchHotCoffeeSpec(widget.title);
    List<Latte> latteList = await coffeeDB.fetchLatteSpecEdit(widget.title);
    List<Croffles> croffleList = await coffeeDB.fetchCrofflesSpec(widget.title);
    List<Others> othersList = await coffeeDB.fetchOthersSpec(widget.title);
    setState(() {
      if(widget.type == "iced"){
        status = icedList[0].status;
      }
      else if(widget.type == "hot"){
        status = hotList[0].status;
      }
      else if(widget.type == "latte"){
        status = latteList[0].status;
      }
      else if(widget.type == "others"){
        status = othersList[0].status;
      }
      else{
        status = croffleList[0].status;
      }
    });
    return status;
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
                                      "Edit Item",
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Align(
                                        alignment: AlignmentDirectional.centerEnd,
                                        widthFactor: 11.3,
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
                            children: [
                                customRadioButton("Available", 1),
                                const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                                customRadioButton("Unavailable", 0)
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
                                  offset: const Offset(0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextButton(
                              onPressed: () async {
                                await coffeeDB.updateItemStatus(widget.title, widget.type, value);
                                await alertDialog(context, "Successfully updated item!");
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
    return OutlinedButton(
      onPressed: () {
        setState(() {
          value = index;
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