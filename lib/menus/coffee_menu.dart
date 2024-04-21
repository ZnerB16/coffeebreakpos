import 'package:coffee_break_pos/database/classes/hot_coffee.dart';
import 'package:coffee_break_pos/database/classes/iced_coffee.dart';
import 'package:coffee_break_pos/database/coffee_db.dart';
import 'package:flutter/material.dart';

class CoffeeMenu extends StatefulWidget{
  const CoffeeMenu ({super.key});

  @override
  _CoffeeMenuState createState() => _CoffeeMenuState();
}
class _CoffeeMenuState extends State<CoffeeMenu>{

  List<Map<String, dynamic>> gridMap= [];
  String defaultMenu = "iced";
  bool isHotActive = false;
  bool isIcedActive = true;

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      gridMap = [];
      await getMapVal();
    });
  }

  Future<void> getMapVal() async {
    var coffeeDB = CoffeeDB();
    List<HotCoffee> hotList = await coffeeDB.fetchHotCoffee();
    List<IcedCoffee> icedList = await coffeeDB.fetchIcedCoffee();
    setState(() {
      if(defaultMenu == "hot"){
        for(int i = 0; i < hotList.length; i++){
          gridMap.add(
              {
                "imgPath": "assets/images/coffee-cup.png",
                "title": hotList[i].name
              }
          );
        }
      }
      else {
        for(int i = 0; i < icedList.length; i++){
          gridMap.add(
              {
                "imgPath": "assets/images/coffee-cup.png",
                "title": icedList[i].name
              }
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                            color: isIcedActive? Color(0xf0634832): Color(0xf0ECE7DF),
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
                            onPressed: () {
                              setState(() {
                                defaultMenu = "cold";
                                isHotActive = false;
                                isIcedActive = true;
                                gridMap = [];
                                getMapVal();
                              });
                            },
                            child: Text(
                              'Iced',
                              style: TextStyle(
                                  color: isIcedActive? Colors.white: Colors.black87,
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
                              color: isHotActive? Color(0xf0634832): Color(0xf0ECE7DF),
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
                              setState(() {
                                defaultMenu = "hot";
                                isHotActive = true;
                                isIcedActive = false;
                                gridMap = [];
                                getMapVal();
                              });
                            },
                            child: Text(
                              'Hot',
                              style: TextStyle(
                                  color: isHotActive? Colors.white: Colors.black87,
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
              const Padding(padding: EdgeInsets.only(top: 20)),
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