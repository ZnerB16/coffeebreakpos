import 'package:coffee_break_pos/add_product/main_add.dart';
import 'package:coffee_break_pos/breakdown/main_breakdown.dart';
import 'package:coffee_break_pos/database/classes/employee.dart';
import 'package:coffee_break_pos/employee/employee_info.dart';

import 'create_employee.dart';
import 'package:coffee_break_pos/hero_dialog_route.dart';
import 'package:flutter/material.dart';
import 'package:coffee_break_pos/custom_rect_tween.dart';
import '../database/coffee_db.dart';

class PasswordHeroScreen extends StatefulWidget{
  bool? newEmployee = false;
  String? screen = "";

  PasswordHeroScreen(
      {
        super.key,
        this.newEmployee,
        this.screen
      });

  @override
  State<PasswordHeroScreen> createState() => _PasswordHeroScreenState();
}

class _PasswordHeroScreenState extends State<PasswordHeroScreen> {
  final _controllerPass = TextEditingController();
  var coffeeDB = CoffeeDB();
  List<Map<String, dynamic>> passwords = [];
  bool _passwordVisible = false;
  bool _validate = false;
  String text = "";

  @override
  void initState(){
    super.initState();
    _validate = false;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getPasswords();
      await checkScreen();
    });
  }

  Future<void> checkScreen() async {
    if(widget.screen == "BD" || widget.screen == "AD"){
      text = "Please type admin password:";
    }
    else{
      text = "Please type your password:";
    }
  }

  void checkPassword(String pass){
    setState(() {
      if(pass == "coffeebreak@0408" && widget.screen == "BD"){
        _validate = false;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context){
                  return const BreakdownScreen();
                }
            )
        );
      }
      else if(pass == "coffeebreak@0408" && widget.screen == "AD"){
        _validate = false;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context){
                  return const MainAddScreen();
                }
            )
        );
      }
      else{
        if(pass == "create_new@"){
          _validate = false;
          Navigator.push(
              context,
              HeroDialogRoute(
                  builder: (context){
                    return const CreateEmployeeScreen();
                  }
              )
          );
        }
        else{
          for(int i = 0; i < passwords.length; i++){
            if(passwords[i]["password"] == pass){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return EmployeeInfoScreen(employeeID: passwords[i]["employeeID"]);
                      }
                  )
              );
              break;
            }
          }
          _validate = true;
        }
      }

    });
  }
  Future<void> getPasswords() async {
    List<Employee> employeePass = await coffeeDB.getEmployees();

    setState(() {
      for(int i = 0; i < employeePass.length; i++){
        passwords.add({
          "employeeID": employeePass[i].employeeID,
          "password": employeePass[i].password,
        });
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
                    Text(
                        text,
                        style: const TextStyle(
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
                              errorText: _validate ? "Password not found": null,
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