import 'package:coffee_break_pos/breakdown/line_chart.dart';
import 'package:coffee_break_pos/breakdown/orders_bydate.dart';
import 'package:coffee_break_pos/database/coffee_db.dart';
import 'package:coffee_break_pos/order_list/orders_today.dart';
import 'package:flutter/material.dart';

import '../database/classes/order.dart';
import '../hero_dialog_route.dart';

class SalesBreakdownScreen extends StatefulWidget{
  const SalesBreakdownScreen ({super.key});

  @override
  _SalesBreakdownState createState() => _SalesBreakdownState();
}
class _SalesBreakdownState extends State<SalesBreakdownScreen>{

  bool isDayActive = true;
  bool isWeekActive = false;
  bool isMonthActive = false;
  String defaultMenu = "sales";
  int? cupsTracker = 0;
  int? crofflesTracker = 0;
  List<Map<String, dynamic>> salesList = [];
  var coffeeDB = CoffeeDB();

  @override
  void initState(){
    super.initState();
    salesList = [];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getSalesDay();
      await getCounts();
    });
  }
  Future<void> getCounts() async {
    int? count1 = await coffeeDB.countCupsTotal();
    int? count2 = await coffeeDB.countCrofflesTotal();
    setState(() {
      if(count1 != null){
        cupsTracker = count1;
      }
      if(count2 != null){
        crofflesTracker = count2;
      }
    });
  }


  Future<void> getSalesDay() async {
    List<Order> salesDay = await coffeeDB.getSalesDay();
    setState(() {
      for(int i = 0; i < salesDay.length; i++){
        salesList.add(
          {
            "date": salesDay[i].date,
            "sales": salesDay[i].total
          }
        );
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        salesList.isEmpty ? const SizedBox() : Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const LineChartWidget(),
            Column(
              children: [
                _countTracker("Cups", cupsTracker),
                _countTracker("Croffles", crofflesTracker)
              ],
            )
          ],
        ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 15.0),
                child: Scrollbar(
                      thumbVisibility: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: salesList.isEmpty ? 1 : salesList.length,
                        itemBuilder: (context, index) {
                          return salesList.isEmpty ? _emptyList() : _item(salesList, index);
                        },
                      ),
                    ),
                ),
              ),
          ],
    );
  }
  Widget _countTracker(String text, int? count){
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: 100,
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xf0967259),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            Text(
              "$count",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _item(List<Map<String, dynamic>> orders, int index) {
    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color(0xf0ECE0D1).withAlpha(150)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Date: ${orders[index]["date"]}",
                  style: const TextStyle(
                      fontSize: 16
                  ),
                ),
                Text(
                    "Total Sales: ${orders[index]["sales"]}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
              ],
            ),
            Container(
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                  color: const Color(0xf0967259),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 5), // changes position of shadow
                    )]
              ),
              child: TextButton(
                  onPressed: (){
                    Navigator.push(context, HeroDialogRoute(
                        builder: (context){
                          return OrdersByDateScreen(date: orders[index]["date"], total: orders[index]["sales"]);
                        }
                    )
                    );
                  },
                  child: const Text(
                    "More Info ->",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _emptyList(){
    return const Text(
      "No Sales Yet",
      style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.grey
      ),
    );
  }

}