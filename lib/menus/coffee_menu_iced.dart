import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CoffeeMenu extends StatefulWidget{
  const CoffeeMenu ({super.key});

  @override
  _CoffeeMenuState createState() => _CoffeeMenuState();
}
class _CoffeeMenuState extends State<CoffeeMenu>{

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> gridMap= [
      {
        "imgPath": "assets/images/coffee-cup.png",
        "title": "Caramel Macchiato"
      },
      {
        "imgPath": "assets/images/coffee-cup.png",
        "title": "Coffee Caramel"
      },
      {
        "imgPath": "assets/images/coffee-cup.png",
        "title": "Dark Mocha"
      },
      {
        "imgPath": "assets/images/coffee-cup.png",
        "title": "Espresso Latte"
      },
      {
        "imgPath": "assets/images/coffee-cup.png",
        "title": "French Vanilla"
      },
      {
        "imgPath": "assets/images/coffee-cup.png",
        "title": "Hazelnut"
      },
      {
        "imgPath": "assets/images/coffee-cup.png",
        "title": "Salted Caramel"
      },
      {
        "imgPath": "assets/images/coffee-cup.png",
        "title": "Spanish Latte"
      },

    ];
    return Material(
      color: const Color(0xf0ECE0D1).withAlpha(150),
      child: SizedBox(
        width: 620,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(30),
                      child: Container(
                        width: 300,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white
                        ),
                        child: const TextField(
                          autocorrect: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                            hintStyle: TextStyle(fontSize: 16),
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xf0634832),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                  offset: const Offset(0, 4),
                                )
                              ],
                          ),
                          child: TextButton(
                            onPressed: (){

                            },
                            child: const Text(
                              'Iced',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                              ),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 15)),
                        Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xf0ECE7DF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                  offset: const Offset(0, 4),
                                )
                              ]
                          ),
                          child: TextButton(
                            onPressed: (){

                            },
                            child: const Text(
                              'Hot',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: gridMap.length,
                  itemBuilder: (_, index){
                    return GestureDetector(
                      child: _item(
                          imgPath: gridMap[index]["imgPath"],
                          title: gridMap[index]["title"]
                      ),
                      onTap: (){

                      },
                    );
                  },
                ),
              )

            ],
          ),
      )
    );
  }
  Widget _item(
      {
        required String imgPath,
        required String title
      }
      ) {
    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
              imgPath,
              width: 120,
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}