import 'package:coffee_break_pos/database/coffee_db.dart';
import 'package:coffee_break_pos/popups/success_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../custom_rect_tween.dart';
import '../database/classes/croffles.dart';
import '../database/classes/hot_coffee.dart';
import '../database/classes/iced_coffee.dart';
import '../database/classes/latte.dart';
import '../database/classes/others.dart';

class ChangeHero extends StatefulWidget{
  final String type;
  final String assetPath;
  final String title;

  const ChangeHero({
    super.key,
    required this.type,
    required this.assetPath,
    required this.title
  });

  @override
  _ChangeHeroState createState() => _ChangeHeroState();
}
class _ChangeHeroState extends State<ChangeHero>{
  int value = 1;
  final nameController = TextEditingController();
  final sizeController = TextEditingController();
  final priceController = TextEditingController();
  List<String> sizes = [];
  String selectedSize = "";
  double price = 0.0;

  var coffeeDB = CoffeeDB();
  bool _validate = false;

  @override
  void initState(){
    super.initState();
    nameController.text = widget.title;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getSizes();
      await getDetails();
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
      if(sizes.isNotEmpty){
        selectedSize = sizes[0];
      }
    });
  }

  Future<void> getDetails() async {
    List<IcedCoffee> icedList = await coffeeDB.fetchIcedCoffeeSpecEdit(widget.title);
    List<HotCoffee> hotList = await coffeeDB.fetchHotCoffeeSpec(widget.title);
    List<Latte> latteList = await coffeeDB.fetchLatteSpecEdit(widget.title);
    List<Croffles> croffleList = await coffeeDB.fetchCrofflesSpec(widget.title);
    List<Others> othersList = await coffeeDB.fetchOthersSpec(widget.title);
    setState(() {
      if(widget.type == "iced"){
        price = icedList[0].price;
      }
      else if(widget.type == "hot"){
        price = hotList[0].price;
      }
      else if(widget.type == "latte"){
        price = latteList[0].price;
      }
      else if(widget.type == "others"){
        price = othersList[0].price;
      }
      else{
        price = croffleList[0].price;
      }
      priceController.text = price.toString();
    });
  }

  Future<void> changePrice() async {
    List<IcedCoffee> icedList = await coffeeDB.fetchIcedCoffeeSpecSize(widget.title, selectedSize);
    List<Latte> latteList = await coffeeDB.fetchLatteSpecSize(widget.title, selectedSize);
    setState(() {
      if(widget.type == "iced"){
        price = icedList[0].price;
      }
      else if(widget.type == "latte"){
        price = latteList[0].price;
      }
    });
    priceController.text = price.toString();
  }

  Future<void> updateItem(String name, double price, int status) async {
    if(widget.type == "iced"){
      await coffeeDB.updateIcedCoffee(name, selectedSize, price, status, widget.title);
    }
    else if(widget.type == "hot"){
      await coffeeDB.updateHotCoffee(name, price, status, widget.title);
    }
    else if(widget.type == "latte"){
      await coffeeDB.updateLatte(name, selectedSize, price, status, widget.title);
    }
    else if(widget.type == "croffles"){
      await coffeeDB.updateCroffles(name, price, status, widget.title);
    }
    else if(widget.type == "others"){
      await coffeeDB.updateOthers(name, price, status, widget.title);
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
                width: 600,
                height: 400,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                        widthFactor: 7.8,
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
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        customRadioButton("Available", 1),
                                        const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                                        customRadioButton("Unavailable", 0)
                                      ],
                                    ),
                                    const Padding(padding: EdgeInsets.only(top: 20)),
                                  ],
                                ),
                      
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: TextField(
                                        autocorrect: false,
                                        controller: nameController,
                                        decoration: InputDecoration(
                                          border: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xff13367A),
                                              )
                                          ),
                                          hintText: 'Name',
                                          hintStyle: const TextStyle(fontSize: 16),
                                          errorText: _validate ? "A field is empty": null,
                                          errorStyle: const TextStyle(
                                            height: 0,
                                            fontSize: 10,
                                          ),
                                        ),
                                        style: const TextStyle(
                                            fontSize: 16
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: TextField(
                                        autocorrect: false,
                                        controller: priceController,
                                        decoration: InputDecoration(
                                          border: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xff13367A),
                                              )
                                          ),
                                          hintText: 'Price',
                                          hintStyle: const TextStyle(fontSize: 16),
                                          errorText: _validate ? "A field is empty": null,
                                          errorStyle: const TextStyle(
                                            height: 0,
                                            fontSize: 10,
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                            fontSize: 16
                                        ),
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.only(top:20)),
                                    SizedBox(
                                      width: 150,
                                      child: DropdownButtonFormField<String>(
                                        value: selectedSize,
                                        items: sizes.map((size) => DropdownMenuItem(
                                            value: size,
                                            child: Text(
                                                size, style: const TextStyle(fontSize: 16)
                                            )
                                        )).toList(),
                                        onChanged: (size) async {
                                          setState(() {
                                            selectedSize = size!;
                                          });
                                          await changePrice();
                                        },
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.only(top:20)),
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
                                          try{
                                            await updateItem(nameController.text, double.parse(priceController.text), value);
                                            alertDialog(context, "Successfully udpated item!");
                                          }
                                          catch(e){
                                            ErrorWidget(e);
                                          }
                                        }
                                        ,
                                        child: const Text(
                                          "Update Item",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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