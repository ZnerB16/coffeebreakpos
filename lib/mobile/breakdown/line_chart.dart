import 'package:coffee_break_pos/database/coffee_db.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '/database/classes/order.dart';

class LineChartWidget extends StatefulWidget{
  const LineChartWidget({super.key});

  @override
  _LineChartState createState() => _LineChartState();
}
class _LineChartState extends State<LineChartWidget>{

  final List<Color> gradientColors = [
    const Color(0xf0ffcca3),
    const Color(0xf0a27356)
  ];
  List<Map<String, dynamic>> salesData = [];

  var coffeeDB = CoffeeDB();

  Future<void> getSales() async {
    List<Order> salesList = await coffeeDB.getSalesForChart();
    setState(() {
      for(int i = salesList.length - 1; i >= 0; i--){
        salesData.add(
            {
              "date": salesList[i].date,
              "sales": salesList[i].total
            }
        );
      }
    });
  }
  @override void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      salesData = [];
      await getSales();
    });
  }


  @override
  Widget build(BuildContext context) {
    List<LineChartBarData> lineChartBarData = [LineChartBarData(
      spots: salesData.asMap().entries.map((entry) =>
          FlSpot(entry.key.toDouble(), (entry.value["sales"] / 1000))
      ).toList(),
      isCurved: true,
      gradient: LinearGradient(colors: gradientColors),

      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(colors: gradientColors.map((e) => e.withOpacity(0.3)).toList()),
      ),

    )];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Sales in the Past 7 Days",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            height: 280,
            child: LineChart(
                LineChartData(
                    minY: 0,
                    maxY: 13,
                    titlesData: titlesData,
                    lineBarsData: lineChartBarData,
                    gridData: const FlGridData(show: false)
                )
            ),
          ),
        ),
      ],
    );
  }
  FlTitlesData get titlesData => FlTitlesData(
    bottomTitles: AxisTitles(
      axisNameWidget: const Text("Date", style: TextStyle(fontSize: 12)),
      sideTitles: bottomTitles,
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      axisNameWidget: const Text("Total Sales", style: TextStyle(fontSize: 12)),
      sideTitles: leftTitles(),
    ),
  );

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );
  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    interval: 1,
    reservedSize: 40,
  );
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1k';
        break;
      case 2:
        text = '2k';
        break;
      case 3:
        text = '3k';
        break;
      case 4:
        text = '4k';
        break;
      case 5:
        text = '5k';
        break;
      case 6:
        text = '6k';
        break;
      case 7:
        text = '7k';
        break;
      case 8:
        text = '8k';
        break;
      case 9:
        text = '9k';
        break;
      case 10:
        text = '10k';
        break;
      case 11:
        text = '11k';
        break;
      case 12:
        text = '12k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    if(salesData.isEmpty){
      return Container();
    }
    text = Text(salesData[value.toInt()]["date"].toString().substring(0, 5), style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }
}