import 'package:coffee_break_pos/database/classes/dtr.dart';
import 'package:coffee_break_pos/database/coffee_db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeBreakdownScreen extends StatefulWidget{
  const EmployeeBreakdownScreen ({super.key});

  @override
  _EmployeeBreakdownState createState() => _EmployeeBreakdownState();
}
class _EmployeeBreakdownState extends State<EmployeeBreakdownScreen>{

  var coffeeDB = CoffeeDB();
  List<Map<String, dynamic>> dtr = [];

  Future<void> getEmployeeDTR() async {
    List<DTR> dtrList = await coffeeDB.getDTR();
    DateTime timeInParse, timeOutParse;
    Duration dif;

    setState(() {
      for(int i = 0; i < dtrList.length; i++){
        timeInParse = DateFormat.jm().parse(dtrList[i].timeIn);
        timeOutParse = DateFormat.jm().parse(dtrList[i].timeOut);
        dif = timeOutParse.difference(timeInParse);

        dtr.add(
          {
            "name": dtrList[i].employeeName,
            "date": dtrList[i].date,
            "time_in": dtrList[i].timeIn,
            "time_out": dtrList[i].timeOut,
            "hours_rendered": dif.inHours
          }
        );
      }
    });
  }
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dtr = [];
      await getEmployeeDTR();
    });
  }
  String getFirstWord(String name) => name.isNotEmpty
      ? name.trim().split(RegExp(' +')).map((s) => s).take(1).join()
      : '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Employee DTR History",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: 600,
            child: Scrollbar(
                thumbVisibility: true,
                scrollbarOrientation: ScrollbarOrientation.right,
                thickness: 5,
                child: SingleChildScrollView(
                    child: DataTable(
                        border: TableBorder.all(),
                        columnSpacing: 30,
                        columns:  const [
                          DataColumn(label: Center(
                            child: Text(
                                'Name',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                          ),
                          ),
                          DataColumn(label: Center(
                            child: Text(
                                'Date',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                          ),
                          ),
                          DataColumn(label: Center(
                            child: Text(
                                'Time-In',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                          ),
                          ),
                          DataColumn(label: Center(
                            child: Text(
                                'Time-Out',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                          ),
                          ),
                          DataColumn(label: Center(
                            child: Text(
                                'Hours Rendered',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                          ),
                          ),
                        ],
                        rows: dtr.map((e) =>
                            DataRow(cells: [
                              DataCell(Text(getFirstWord(e["name"]),
                                style: const TextStyle(fontSize: 16),),
                              ),
                              DataCell(Text(e["date"],
                                style: const TextStyle(fontSize: 16),),
                              ),
                              DataCell(Center(
                                child: Text(e["time_in"],
                                  style: const TextStyle(fontSize: 16),),
                              )),
                              DataCell(Center(
                                child: Text(e["time_out"].toString(),
                                  style: const TextStyle(fontSize: 16),),
                              )),
                              DataCell(Center(
                                child: Text(e["hours_rendered"].toString(),
                                  style: const TextStyle(fontSize: 16),),
                              )),
                            ])
                        ).toList()
                    )
                )
            ),
          ),
        ),
      ],
    );
  }

}