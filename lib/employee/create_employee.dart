import 'package:coffee_break_pos/database/classes/employee.dart';
import 'package:coffee_break_pos/database/coffee_db.dart';
import 'package:coffee_break_pos/hero_dialog_route.dart';
import 'package:flutter/material.dart';

import '/custom_rect_tween.dart';
import 'employee_info.dart';

class CreateEmployeeScreen extends StatefulWidget{
  const CreateEmployeeScreen ({super.key});

  @override
  _CreateEmployeeState createState() => _CreateEmployeeState();
}
class _CreateEmployeeState extends State<CreateEmployeeScreen>{
  var _controllerName = TextEditingController();
  var _controllerAddress = TextEditingController();
  var _controllerBD = TextEditingController();
  var _controllerPass = TextEditingController();
  bool _passwordVisible = false;
  bool _validate = false;
  var coffeeDB = CoffeeDB();

  @override
  void initState(){
    super.initState();
    _validate = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
          child: Hero(
              tag: 'password-hero',
              createRectTween: (begin, end){
                return CustomRectTween(begin: begin, end: end);
              },
              child: Material(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: SizedBox(
                  width: 600,
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                            "New Employee Form",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: SizedBox(
                                      width: 250,
                                      child: TextField(
                                        autocorrect: false,
                                        controller: _controllerName,
                                        decoration: InputDecoration(
                                          border: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xff13367A),
                                              )
                                          ),
                                            hintText: 'Name',
                                            hintStyle: const TextStyle(fontSize: 16),
                                            errorText: _validate ? "A field is empty": null,
                                            errorStyle: const TextStyle(
                                              height: 0,
                                              fontSize: 10,
                                            ),
                                        ),
                                        style: const TextStyle(
                                            fontSize: 16
                                        ),
                                      ),
                                    ),
                                  ),
                                const Padding(padding: EdgeInsets.only(top: 10)),
                               Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: SizedBox(
                                      width: 250,
                                      child: TextField(
                                        autocorrect: false,
                                        controller: _controllerAddress,
                                        decoration: InputDecoration(
                                          border: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xff13367A),
                                              )
                                          ),
                                          hintText: 'Address',
                                          hintStyle: const TextStyle(fontSize: 16),
                                          errorText: _validate ? "A field is empty": null,
                                          errorStyle: const TextStyle(
                                            height: 0,
                                            fontSize: 10,
                                          ),
                                        ),
                                        style: const TextStyle(
                                            fontSize: 16
                                        ),
                                      ),
                                    ),
                                  ),
                                const Padding(padding: EdgeInsets.only(top: 10)),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: SizedBox(
                                      width: 250,
                                      child: TextField(
                                        autocorrect: false,
                                        controller: _controllerBD,
                                        decoration: InputDecoration(
                                            border: const UnderlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xff13367A),
                                                )
                                            ),
                                          hintText: 'Birthdate',
                                          hintStyle: const TextStyle(fontSize: 16),
                                            errorText: _validate ? "A field is empty": null,
                                            errorStyle: const TextStyle(
                                              height: 0,
                                              fontSize: 10,
                                            ),
                                          prefixIcon: const Icon(Icons.calendar_today)
                                        ),
                                        style: const TextStyle(
                                            fontSize: 16
                                        ),
                                        readOnly: true,
                                        onTap: (){
                                          _selectDate();
                                        },
                                      ),
                                    ),
                                  ),
                                const Padding(padding: EdgeInsets.only(top: 20)),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: SizedBox(
                                      width: 200,
                                      child: TextField(
                                        obscureText: !_passwordVisible,
                                        autocorrect: false,
                                        controller: _controllerPass,
                                        decoration: InputDecoration(
                                            border: const UnderlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xff13367A),
                                                )
                                            ),
                                            hintText: 'Password',
                                            hintStyle: const TextStyle(fontSize: 16),
                                            errorText: _validate ? "A field is empty": null,
                                            errorStyle: const TextStyle(
                                              height: 0,
                                              fontSize: 10,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: const Color(0xf038220f),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _passwordVisible = !_passwordVisible;
                                                });
                                              },
                                            )
                                        ),
                                        style: const TextStyle(
                                            fontSize: 16
                                        ),
                                      ),
                                    ),
                                  ),
                                const Padding(padding: EdgeInsets.only(top: 30)),
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
                                        offset: const Offset(0, 5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: TextButton(
                                    onPressed:  () async {
                                        if (_controllerName.text.isNotEmpty &&
                                            _controllerPass.text.isNotEmpty &&
                                            _controllerAddress.text.isNotEmpty &&
                                            _controllerBD.text.isNotEmpty) {
                                          setState(() {
                                            _validate = false;
                                          });
                                          Navigator.push(context,
                                              HeroDialogRoute(
                                                  builder: (context){
                                                    return PasswordScreen(
                                                      newEmployee: true,
                                                      name: _controllerName.text,
                                                      password: _controllerPass.text,
                                                      address: _controllerAddress.text,
                                                      birthdate: _controllerBD.text,
                                                    );
                                                  }
                                              )
                                          );
                                        }
                                        else{
                                          setState(() {
                                            _validate = true;
                                          });
                                        }
                                    },
                                    child: const Text(
                                      "Done",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),)
                      ],
                    ),
                  )
                ),
              ),
            ),
      ),
    );
  }
  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)
    );
    if(pickedDate != null){
      setState(() {
        _controllerBD.text = pickedDate.toString().split(" ")[0];
      });
    }
  }
}

class PasswordScreen extends StatefulWidget{
  bool? newEmployee = false;
  String? name = "";
  String? address = "";
  String? birthdate = "";
  String? password = "";

  PasswordScreen(
      {
        super.key,
        this.newEmployee,
        this.name,
        this.address,
        this.birthdate,
        this.password
      });

  @override
  State<PasswordScreen> createState() => _PasswordState();
}

class _PasswordState extends State<PasswordScreen> {
  final _controllerPass = TextEditingController();
  var coffeeDB = CoffeeDB();
  List<String> passwords = [];
  bool _passwordVisible = false;
  bool _validate = false;

  @override
  void initState(){
    super.initState();
    _validate = false;
  }

  void checkPassword(String pass) async {
    setState(() async {
      if(widget.newEmployee! && pass == "coffeebreak@0408"){
        _validate = false;
        await coffeeDB.insertEmployee(
            widget.name!,
            widget.password!,
            widget.address!,
            widget.birthdate!
        );
        List<Employee> employee = await coffeeDB.getLatestEmployee();

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context){
                  return EmployeeInfoScreen(employeeID: employee[0].employeeID);
                }
            )
        );
      }
      else{
        _validate = true;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Hero(
            tag: 'password-hero',
            createRectTween: (begin, end){
              return CustomRectTween(begin: begin, end: end);
            },
            child: Material(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              child: SizedBox(
                width: 400,
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Please enter admin password: ",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SizedBox(
                        width: 250,
                        child: TextField(
                          obscureText: !_passwordVisible,
                          autocorrect: false,
                          controller: _controllerPass,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff13367A),
                                )
                            ),
                            hintText: 'Password',
                            hintStyle: const TextStyle(fontSize: 16),
                            errorText: _validate ? "Password incorrect": null,
                            errorStyle: const TextStyle(
                              height: 0,
                              fontSize: 10,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color(0xf038220f),
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          style: const TextStyle(
                              fontSize: 16
                          ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xf0967259),
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
                        onPressed: (){
                          checkPassword(_controllerPass.text);
                        },
                        child: const Text(
                          "Done",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),)
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}