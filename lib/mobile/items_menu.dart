import 'package:coffee_break_pos/mobile/item_add_cart.dart';
import 'package:flutter/material.dart';

import '../database/classes/croffles.dart';
import '../database/classes/hot_coffee.dart';
import '../database/classes/iced_coffee.dart';
import '../database/classes/latte.dart';
import '../database/classes/others.dart';
import '../database/classes/waffles.dart';
import '../database/coffee_db.dart';
import '../hero_dialog_route.dart';

class ItemsMenu extends StatefulWidget{
  final void Function() onAddCart;

  const ItemsMenu ({super.key, required this.onAddCart});

  @override
  _ItemsMenuState createState() => _ItemsMenuState();

}
class _ItemsMenuState extends State<ItemsMenu>{

  List<Map<String, dynamic>> gridMap= [];
  String defaultMenu = "iced";

  bool isHotActive = false;
  bool isIcedActive = true;
  int count = 0;
  bool isCoffeeActive = true;
  bool isLatteActive = false;
  bool isCrofflesActive = false;
  bool isOthersActive = false;
  bool isWaffleActive = false;

  double topButtonWidth = 80;
  double topButtonHeight = 40;
  double buttonFontSize = 16;

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      gridMap = [];
      await getMapVal();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Row(
            children: [
              Container(
                width: topButtonWidth,
                height: topButtonHeight,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  color: isCoffeeActive? const Color(0xf0634832): null,
                ),
                child: TextButton(
                  onPressed: (){
                    defaultMenu = "iced";
                    isCoffeeActive = true;
                    isLatteActive = false;
                    isCrofflesActive = false;
                    isOthersActive = false;
                    isHotActive = false;
                    isWaffleActive = false;
                    isIcedActive = true;
                    gridMap = [];
                    getMapVal();
                  },
                  child: Text(
                    'Coffee',
                    style: TextStyle(
                        color: isCoffeeActive? Colors.white: Colors.black87,
                        fontSize: buttonFontSize,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Container(
                width: topButtonWidth,
                height: topButtonHeight,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    color: isLatteActive? const Color(0xf0634832): null
                ),
                child: TextButton(
                  onPressed: (){
                    defaultMenu = "latte";
                    isCoffeeActive = false;
                    isLatteActive = true;
                    isCrofflesActive = false;
                    isOthersActive = false;
                    isWaffleActive = false;
                    gridMap = [];
                    getMapVal();
                  },
                  child: Text(
                    'Latte',
                    style: TextStyle(
                        color: isLatteActive? Colors.white: Colors.black87,
                        fontSize: buttonFontSize,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Container(
                width: topButtonWidth,
                height: topButtonHeight,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    color: isCrofflesActive? const Color(0xf0634832): Colors.white
                ),
                child: TextButton(
                  onPressed: (){
                    defaultMenu = "croffles";
                    isCoffeeActive = false;
                    isLatteActive = false;
                    isCrofflesActive = true;
                    isOthersActive = false;
                    isWaffleActive = false;
                    gridMap = [];
                    getMapVal();
                  },
                  child: Text(
                    'Croffles',
                    style: TextStyle(
                        color: isCrofflesActive? Colors.white: Colors.black87,
                        fontSize: buttonFontSize,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Container(
                width: topButtonWidth,
                height: topButtonHeight,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    color: isWaffleActive? const Color(0xf0634832): null
                ),
                child: TextButton(
                  onPressed: (){
                    defaultMenu = "waffles";
                    isCoffeeActive = false;
                    isLatteActive = false;
                    isCrofflesActive = false;
                    isOthersActive = false;
                    isWaffleActive = true;
                    gridMap = [];
                    getMapVal();
                  },
                  child: Text(
                    'Waffles',
                    style: TextStyle(
                        color: isWaffleActive? Colors.white: Colors.black87,
                        fontSize: buttonFontSize,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Container(
                width: topButtonWidth,
                height: topButtonHeight,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    color: isOthersActive? const Color(0xf0634832): null
                ),
                child: TextButton(
                  onPressed: (){
                    defaultMenu = "others";
                    isCoffeeActive = false;
                    isLatteActive = false;
                    isCrofflesActive = false;
                    isOthersActive = true;
                    isWaffleActive = false;
                    gridMap = [];
                    getMapVal();
                  },
                  child: Text(
                    'Others',
                    style: TextStyle(
                        color: isOthersActive? Colors.white: Colors.black87,
                        fontSize: buttonFontSize,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: isCoffeeActive,
                  child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: isIcedActive? const Color(0xf0634832): const Color(0xf0ECE7DF),
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
                          defaultMenu = "iced";
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
                ),
                const Padding(padding: EdgeInsets.only(left: 15)),
                Visibility(
                  visible: isCoffeeActive,
                  child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: isHotActive? const Color(0xf0634832): const Color(0xf0ECE7DF),
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
                ),
              ],
            )
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Scrollbar(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: gridMap.length,
                itemBuilder: (_, index){
                  String assetPath = gridMap[index]["imgPath"];
                  if(assetPath.isEmpty){
                    assetPath = "assets/images/coffee-cup.png";
                  }
                  return GestureDetector(
                    onTap: !gridMap[index]["status"] ? null : () {
                      Navigator.push(context, HeroDialogRoute(
                          builder: (context){
                            return ItemAddHero(
                                title: gridMap[index]["title"],
                                type: defaultMenu,
                                assetPath: gridMap[index]["imgPath"]
                            );
                          }
                        )
                      ).then((_){
                        widget.onAddCart();
                      });
                    },
                    child: _item(
                        imgPath: assetPath,
                        title: gridMap[index]["title"],
                        status: gridMap[index]["status"]
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
  Future<void> getMapVal() async {
    var coffeeDB = CoffeeDB();
    List<HotCoffee> hotList = await coffeeDB.fetchHotCoffee();
    List<IcedCoffee> icedList = await coffeeDB.fetchIcedCoffee();
    List<Latte> latteList = await coffeeDB.fetchLatte();
    List<Croffles> croffleList = await coffeeDB.fetchCroffles();
    List<Others> othersList = await coffeeDB.fetchOthers();
    List<Waffles> waffleList = await coffeeDB.fetchWaffles();

    bool status = true;
    setState(() {
      if(defaultMenu == "hot"){
        for(int i = 0; i < hotList.length; i++){
          status = hotList[i].status == 0 ? false : true;
          gridMap.add(
              {
                "imgPath": "assets/images/coffee-cup.png",
                "title": hotList[i].name,
                "status": status
              }
          );
        }
      }
      else if (defaultMenu == "latte"){
        for(int i = 0; i < latteList.length; i++){
          status = latteList[i].status == 0 ? false : true;
          gridMap.add(
              {
                "imgPath": latteList[i].imagePath,
                "title": latteList[i].name,
                "status": status
              }
          );
        }
      }
      else if(defaultMenu == "croffles"){
        for(int i = 0; i < croffleList.length; i++){
          status = croffleList[i].status == 0 ? false : true;
          gridMap.add(
              {
                "imgPath": "assets/images/waffle.png",
                "title": croffleList[i].name,
                "status": status
              }
          );
        }
      }
      else if(defaultMenu == "waffles"){
        for(int i = 0; i < waffleList.length; i++){
          status = waffleList[i].status == 0 ? false : true;
          gridMap.add(
              {
                "imgPath": "assets/images/waffle.png",
                "title": waffleList[i].name,
                "status": status
              }
          );
        }
      }
      else if(defaultMenu == "others"){
        if (othersList.isNotEmpty) {
          for(int i = 0; i < othersList.length; i++){
            status = othersList[i].status == 0 ? false : true;
            gridMap.add(
                {
                  "imgPath": "assets/images/cookies.png",
                  "title": othersList[i].name,
                  "status": status
                }
            );
          }
        }
      }
      else {
        for(int i = 0; i < icedList.length; i++){
          status = icedList[i].status == 0 ? false : true;
          gridMap.add(
              {
                "imgPath": icedList[i].imagePath,
                "title": icedList[i].name,
                "status": status
              }
          );
        }
      }
    });
  }

  Widget _item(
      {
        required String imgPath,
        required String title,
        required bool status
      }
      ) {
    return Material(
      child: Container(
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        padding: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  imgPath,
                  width: 70,
                ),
                Visibility(
                  visible: !status,
                  child: Image.asset(
                        'assets/images/block.png',
                      width: 50,
                    fit: BoxFit.fill,
                    ),
                ),
                Visibility(
                  visible: !status,
                  child: const Text(
                    "Unavailable",
                      style:TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
              ]
            ),
            const Padding(padding: EdgeInsets.only(top: 15)),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }



}