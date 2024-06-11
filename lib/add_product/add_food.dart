import 'package:coffee_break_pos/database/coffee_db.dart';
import 'package:coffee_break_pos/hero_dialog_route.dart';
import 'package:flutter/material.dart';

import '../custom_rect_tween.dart';
import '../popups/success_popup.dart';

class AddFood extends StatefulWidget{
  const AddFood({super.key});

  @override
  _AddFoodState createState() => _AddFoodState();
}
class _AddFoodState extends State<AddFood>{
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  var coffeeDB = CoffeeDB();

  bool _validate = false;

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
                width: 400,
                height: 200,
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
                                      "Add Food",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              addButton(
                                  "Croffle",
                                  () {
                                    Navigator.push(context, HeroDialogRoute(
                                        builder: (context){
                                          return addFood("croffle");
                                        }
                                    ));
                                  }
                              ),
                              addButton(
                                  "Waffle",
                                  () {

                                  }
                              ),
                            ],
                          ),
                          const Spacer(),
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
  Widget addButton(String text, Function() onPressed){
    return Container(
      width: 80,
      height: 60,
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
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16
            ),
            textAlign: TextAlign.center,
          )
      ),
    );
  }
  Widget addFood(String type){
    // Condition for croffle
    if(type == "croffle"){
      return Center(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Hero(
                tag: "Croffle-Add-Hero",
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
                    width: 350,
                    height: 270,
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
                                            "Add Croffle",
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
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 180,
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
                                          width: 180,
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
                                              try {
                                                await coffeeDB.addCroffle(nameController.text, double.parse(priceController.text));
                                                await alertDialog(context, "Successfully added item!");
                                                Navigator.pop(context);
                                              } catch (e) {
                                                ErrorWidget(e);
                                              }
                                            }
                                            ,
                                            child: const Text(
                                              "Add Item",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
              )
          )
      );
    }
    // For waffle
    else{
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Hero(
            tag: "Hot-Hero",
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
                  width: 350,
                  height: 280,
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
                                        "Add Hot Coffee",
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
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 180,
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
                                      width: 180,
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

                                        }
                                        ,
                                        child: const Text(
                                          "Add Item",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
  }
}