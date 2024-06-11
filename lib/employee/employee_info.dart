import 'package:coffee_break_pos/database/classes/dtr.dart';
import 'package:coffee_break_pos/database/classes/employee.dart';
import 'package:coffee_break_pos/database/coffee_db.dart';
import 'package:coffee_break_pos/sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeInfoScreen extends StatefulWidget{
  final int employeeID;

  const EmployeeInfoScreen ({
    super.key,
    required this.employeeID
  });

  @override
  _EmployeeInfoState createState() => _EmployeeInfoState();
}
class _EmployeeInfoState extends State<EmployeeInfoScreen>{
  String name = "";
  String address = "";
  String birthdate = "";
  String _password = "";
  List<Map<String, dynamic>> dtrList = [];
  bool timeInExists = false;
  bool timeOutExists = false;

  var coffeeDB = CoffeeDB();
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dtrList = [];
      timeInExists = false;
      timeOutExists = false;
      await checkTimeIn();
      await checkTimeOut();
      await getEmployeeDetails();
      await updateDTR();

    });
  }

  Future<void> getEmployeeDetails() async {
    List<Employee> employee = await coffeeDB.getEmployeeFromID(widget.employeeID);
    setState(() {
      name = employee[0].name;
      address = employee[0].address;
      birthdate = employee[0].birthdate;
      _password = employee[0].password;
    });
  }
  Future<void> checkTimeIn() async{
    List<DTR> latestDate = await coffeeDB.getLatestDateEmployeeFromID(widget.employeeID);

    DateTime now = DateTime.now();
    String dateToday = DateFormat('MM/dd/yyyy').format(now);

    if(latestDate.isNotEmpty){
      if(latestDate[0].date == dateToday && latestDate[0].timeIn.isNotEmpty){
        timeInExists = true;
      }
    }
  }
  Future<void> checkTimeOut() async{
    List<DTR> latestDate = await coffeeDB.getLatestDateEmployeeFromID(widget.employeeID);

    if (latestDate.isNotEmpty) {
      if(latestDate[0].timeOut.isEmpty){
        timeOutExists = false;
      }
      else{
        timeOutExists = true;
      }
    }
  }
  Future<void> updateDTR() async {
    List<DTR> dtr = await coffeeDB.getEmployeeDetailsFromID(widget.employeeID);
    setState(() {

      for(int i = 0; i < dtr.length; i++){
        dtrList.add(
            {
              "date": dtr[i].date,
              "time-in": dtr[i].timeIn,
              "time-out": dtr[i].timeOut
            }
        );
      }
    });
  }
  Future<void> timeIn() async {
    List<DTR> latestDate = await coffeeDB.getLatestDateEmployeeFromID(widget.employeeID);

    DateTime now = DateTime.now();
    String dateToday = DateFormat('MM/dd/yyyy').format(now);
    String formattedTime = DateFormat('MM/dd/yyyy hh:mm').format(now);

    if (latestDate.isEmpty) {
      await coffeeDB.insertEmployeeDetailsTimeIn(widget.employeeID, dateToday, formattedTime);
    }
    else if(latestDate[0].date != dateToday){
      await coffeeDB.insertEmployeeDetailsTimeIn(widget.employeeID, dateToday, formattedTime);
    }
  }
  Future<void> timeOut() async {
    List<DTR> latestDate = await coffeeDB.getLatestDateEmployeeFromID(widget.employeeID);

    DateTime now = DateTime.now();
    String formattedTime = DateFormat('MM/dd/yyyy hh:mm').format(now);

    if(latestDate[0].timeOut.isEmpty){
      await coffeeDB.updateEmployeeDetailsTimeOut(widget.employeeID, latestDate[0].date, formattedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Sidebar(currentScreen: "TM"),
          Container(
              width: 600,
              color: const Color(0xf0ECE0D1).withAlpha(150),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Name: $name",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      "Address: $address",
                      style: const TextStyle(
                          fontSize: 20,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      "Birthdate: $birthdate",
                      style: const TextStyle(
                          fontSize: 20,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    SizedBox(
                      width: 600,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              color: timeInExists ? Colors.grey : const Color(0xf0967259),
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
                              onPressed: timeInExists ? null : () async {
                                await timeIn();
                                await checkTimeIn();
                                dtrList = [];
                                await updateDTR();
                              },
                              child: const Text(
                                "Time-In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              color: timeOutExists ? Colors.grey : const Color(0xf0967259),
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
                              onPressed: timeOutExists ? null : () async {
                                await timeOut();
                                await checkTimeOut();
                                dtrList = [];
                                await updateDTR();
                              },
                              child: const Text(
                                "Time-Out",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Expanded(
                      child: SizedBox(
                        width: 600,
                        child: Scrollbar(
                          thumbVisibility: true,
                          scrollbarOrientation: ScrollbarOrientation.right,
                          thickness: 5,
                          child: SingleChildScrollView(
                            child: DataTable(
                                border: TableBorder.all(),
                                columns:  const [
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
                                ],
                                rows: dtrList.map((e) =>
                                  DataRow(cells: [
                                    DataCell(Text(e["date"],
                                      style: const TextStyle(fontSize: 16),),
                                    ),
                                    DataCell(Center(
                                      child: Text(e['time-in'].isEmpty ? "" : DateFormat.jm().format(DateFormat('MM/dd/yyyy hh:mm').parse(e["time-in"])),
                                        style: const TextStyle(fontSize: 16),),
                                    )),
                                    DataCell(Center(
                                      child: Text(e['time-out'].isEmpty ? "" : DateFormat.jm().format(DateFormat('MM/dd/yyyy hh:mm').parse(e["time-out"])),
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
                ),
              ),
            ),
        ],
      ),
    );
  }
}