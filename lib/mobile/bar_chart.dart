import 'package:coffee_break_pos/database/classes/others.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../database/classes/order_items.dart';
import '../database/coffee_db.dart';

class BarChartWidget extends StatefulWidget{
  final String type;
  final String date;

  const BarChartWidget ({
    super.key,
    required this.type,
    required this.date
  });

  @override
  _BarChartState createState() => _BarChartState();
}
class _BarChartState extends State<BarChartWidget>{
  List<String> titles = [];
  List<BarChartGroupData> barGroups = [];
  List<OrderItems> salesList = [];
  var coffeeDB = CoffeeDB();
  @override
  void initState(){
    super.initState();
    salesList = [];
    titles = [];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCupsForChart();
    });
  }
  Future<void> getCupsForChart() async{
    List<OrderItems> icedCups = await coffeeDB.getIcedCoffeeCups(widget.date);
    List<OrderItems> hotCups = await coffeeDB.getHotCoffeeCups(widget.date);
    List<OrderItems> latteCups = await coffeeDB.getLatteCups(widget.date);
    List<OrderItems> croffles = await coffeeDB.getCrofflesSales(widget.date);
    List<OrderItems> others = await coffeeDB.getOthersSales(widget.date);
    List<OrderItems> addOns = await coffeeDB.getAddOnSales(widget.date);
    setState(() {
      if(icedCups.isNotEmpty || hotCups.isNotEmpty || latteCups.isNotEmpty || croffles.isNotEmpty || addOns.isNotEmpty){
        if(widget.type == "iced"){
          salesList = icedCups;
        }
        else if(widget.type == "hot"){
          salesList = hotCups;
        }
        else if(widget.type == "latte"){
          salesList = latteCups;
        }
        else if(widget.type == "add_ons"){
          salesList = addOns;
        }
        else if(widget.type == "others"){
          salesList = others;
        }
        else {
          salesList = croffles;
        }

        for(int i = 0; i < salesList.length; i++){
          titles.add(
            getInitials(salesList[i].productName, widget.type)
          );
          barGroups.add(
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: salesList[i].qty.toDouble(),
                    gradient: _barsGradient,
                  )
                ],
                showingTooltipIndicators: [0],
              )
          );
        }
      }
    });
  }
  String getInitials(String name, String type) => name.isNotEmpty
      ? name.trim().split(RegExp(' +')).map((s) => type != "latte" && type != "others" ? s[0] : s[0] + s[1]).take(type == "hot" ? 2 : 5).join()
      : '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 180,
      child: BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups,
          gridData: const FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: 50,
          groupsSpace: 2
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      getTooltipColor: (group) => Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 2,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xf0967259),
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text;
    text = titles[value.toInt()];

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 20,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(
      show: true,
      border: const Border.fromBorderSide(
          BorderSide(
            color: Color(0xf0967259),
            width: 2,

          )
      )
  );

  LinearGradient get _barsGradient => const LinearGradient(
    colors: [
      Color(0xf0ECE0D1),
      Color(0xf0967259),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
}