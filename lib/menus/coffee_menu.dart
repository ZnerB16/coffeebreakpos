import 'package:coffee_break_pos/database/classes/hot_coffee.dart';
import 'package:coffee_break_pos/database/classes/iced_coffee.dart';
import 'package:coffee_break_pos/database/classes/latte.dart';
import 'package:coffee_break_pos/database/coffee_db.dart';
import 'package:coffee_break_pos/menus/cart.dart';
import 'package:coffee_break_pos/menus/order_slip.dart';
import 'package:flutter/material.dart';

import '../database/classes/croffles.dart';
import '../hero_dialog_route.dart';
import 'globals.dart' as globals;

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
  int count = 0;
  bool isCoffeeActive = true;
  bool isLatteActive = false;
  bool isCrofflesActive = false;

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
    List<Latte> latteList = await coffeeDB.fetchLatte();
    List<Croffles> croffleList = await coffeeDB.fetchCroffles();
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
      else if (defaultMenu == "latte"){
        for(int i = 0; i < latteList.length; i++){
          gridMap.add(
              {
                "imgPath": "assets/images/coffee-cup.png",
                "title": latteList[i].name
              }
          );
        }
      }
      else if(defaultMenu == "croffles"){
        for(int i = 0; i < croffleList.length; i++){
          gridMap.add(
              {
                "imgPath": "assets/images/coffee-cup.png",
                "title": croffleList[i].name
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
    return Row(
      children: [Material(
        color: const Color(0xf0ECE0D1).withAlpha(150),
        child: SizedBox(
          width: 480,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        height: 50,
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
                            gridMap = [];
                            getMapVal();
                          },
                          child: Text(
                            'Coffee',
                            style: TextStyle(
                                color: isCoffeeActive? Colors.white: Colors.black87,
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 50,
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
                            gridMap = [];
                            getMapVal();
                          },
                          child: Text(
                            'Latte',
                            style: TextStyle(
                                color: isLatteActive? Colors.white: Colors.black87,
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 50,
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
                            gridMap = [];
                            getMapVal();
                          },
                          child: Text(
                            'Croffles',
                            style: TextStyle(
                                color: isCrofflesActive? Colors.white: Colors.black87,
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(30),
                        child: Container(
                          width: 220,
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
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
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
                  ],
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Scrollbar(
                      child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemCount: gridMap.length,
                          itemBuilder: (_, index){
                            return GestureDetector(
                              child: _item(
                                  imgPath: gridMap[index]["imgPath"],
                                  title: gridMap[index]["title"]
                              ),
                              onTap: (){
                                Navigator.of(context).push(HeroDialogRoute(
                                  builder: (context){
                                    return Cart(
                                        title: gridMap[index]["title"],
                                        type: defaultMenu
                                    );
                                  },
                                )).then((_) => setState(() {
                                  if(globals.orderList.isNotEmpty && count != globals.orderList.length){
                                    computeTotal();
                                    count = globals.orderList.length;
                                  }
                                }));
                              },
                            );
                          },
                        ),
                    ),
                    ),
                ),
              ],
            ),
        )
      ),
        CurrentOrderScreen(orders: globals.orderList)
      ]
    );
  }
  void computeTotal() {
    globals.total = globals.total + globals.orderList[globals.orderList.length - 1]["price"];
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
              width: 100,
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          Text(
            title,
            style: const TextStyle(fontSize: 22),
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class CurrentOrderScreen extends StatefulWidget{
  List<Map<String, dynamic>> orders = [];
  CurrentOrderScreen({
    super.key,
    required this.orders
  });

  @override
  _CurrentOrderScreenState createState() => _CurrentOrderScreenState();
}
class _CurrentOrderScreenState extends State<CurrentOrderScreen>{
  final _controllerName = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
      child: Column(
        children: [
          Container(
              width: 350,
              height: 50,
              decoration: BoxDecoration(
                  color: const Color(0xf0967259),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: const Center(
                child: Text(
                  "Current Order",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              )
          ),
          const Padding(padding: EdgeInsets.only(top:20)),
          Container(
              width: 350,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(),
                  color: const Color(0xf0EBEBEB)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextField(
                  autocorrect: false,
                  controller: _controllerName,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Name',
                    hintStyle: TextStyle(fontSize: 20),
                  ),
                  style: const TextStyle(
                      fontSize: 16
                  ),
                ),
              )
          ),
         Container(
                width: 350,
                height: 280,
                color: Colors.white,
                padding: const EdgeInsets.only(top: 10, right: 20),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: DataTable(
                      dataRowMaxHeight: 80,
                      columnSpacing: 20,
                      dataRowMinHeight: 50,
                      horizontalMargin: 5,
                      columns: const [
                        DataColumn(label: Center(
                          child: Text(
                              'Item',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                        ),
                        DataColumn(label: Center(
                          child: Text(
                              'Size',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                        ),
                        DataColumn(label: Center(
                          child: Text(
                              'Qty',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                        ),
                        DataColumn(label: Center(
                          child: Text(
                              'Price',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                        ),
                        DataColumn(label: Center(
                          child: Text(
                              ''
                          ),
                        ),
                        ),
                      ], rows: widget.orders.map((e) =>
                        DataRow(
                            cells: [
                              DataCell(Text(e["name"],
                                style: const TextStyle(fontSize: 16),),
                              ),
                              DataCell(Center(
                                child: Text(e["size"],
                                  style: const TextStyle(fontSize: 16),),
                              )),
                              DataCell(Center(
                                child: Text(e["qty"].toString(),
                                  style: const TextStyle(fontSize: 16),),
                              )),
                              DataCell(Center(
                                child: Text(e["price"].toString(),
                                  style: const TextStyle(fontSize: 16),),
                              )),
                              DataCell(
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          globals.total -= e["price"];
                                          widget.orders.remove(e);
                                        });
                                      },
                                      icon: Image.asset(
                                        "assets/images/delete.png",
                                        width: 32,
                                      )
                                  )
                              )
                            ]
                        )
                    ).toList(),
                    ),
                  ),
                )
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Total:",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 20)),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${globals.total}",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          Container(
            width: 160,
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
              onPressed: widget.orders.isEmpty ? null : () {
                globals.customerName = _controllerName.text;
                  Navigator.push(context, HeroDialogRoute(
                      builder: (context){
                        return const OrderPaymentScreen();
                      })
                  ).then((value) => setState(() {
                    if(!value){
                      globals.orderList = [];
                      widget.orders = [];
                      _controllerName.text = "";
                    }
                  })
                  );
              },
              child: const Text(
                "Complete Order",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}