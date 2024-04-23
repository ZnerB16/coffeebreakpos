import 'package:coffee_break_pos/menus/globals.dart' as globals;
import 'package:flutter/material.dart';

class CurrentOrderScreen extends StatefulWidget{
  const CurrentOrderScreen({super.key});

  @override
  _CurrentOrderScreenState createState() => _CurrentOrderScreenState();
}
class _CurrentOrderScreenState extends State<CurrentOrderScreen>{

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
        child: Column(
        children: [
          Container(
            width: 470,
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
            width: 470,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
                color: const Color(0xf0EBEBEB)
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: TextField(
                autocorrect: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Name',
                  hintStyle: TextStyle(fontSize: 20),
                ),
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            )
          ),
          Container(
            width: 470,
            color: Colors.white,
            padding: const EdgeInsets.only(top: 10, right: 20),
            child: DataTable(
              columns: const [
                DataColumn(label: Center(
                  child: Text(
                      'Item',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
                ),
                DataColumn(label: Center(
                  child: Text(
                      'Size',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
                ),
                DataColumn(label: Center(
                  child: Text(
                      'Qty',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
                ),
                DataColumn(label: Center(
                  child: Text(
                      'Price',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
                ),
              ], rows: globals.orderList.map((e) =>
                    DataRow(
                        cells: [
                          DataCell(Text(e["name"])),
                          DataCell(Text(e["size"])),
                          DataCell(Text(e["qty"].toString())),
                          DataCell(Text(e["price"].toString())),
                        ]
                    )
            ).toList(),
            )
          )
      ],
    ),
    );
  }
}