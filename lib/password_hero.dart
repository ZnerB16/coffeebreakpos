import 'package:coffee_break_pos/create_employee.dart';
import 'package:coffee_break_pos/hero_dialog_route.dart';
import 'package:flutter/material.dart';
import 'package:coffee_break_pos/custom_rect_tween.dart';

import 'database/coffee_db.dart';

class PasswordHeroScreen extends StatefulWidget{
  const PasswordHeroScreen({super.key});

  @override
  State<PasswordHeroScreen> createState() => _PasswordHeroScreenState();
}

class _PasswordHeroScreenState extends State<PasswordHeroScreen> {
  final _controllerPass = TextEditingController();
  var coffeeDB = CoffeeDB();
  List<String> passwords = [];
  bool _passwordVisible = false;

  @override
  void initState(){
    super.initState();
  }

  void checkPassword(String pass){
    if(pass == "create_new@"){
      Navigator.push(
        context,
        HeroDialogRoute(
            builder: (context){
              return const CreateEmployeeScreen();
            }
        )
      );
    }
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
                        "Please enter your password: ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800
                        ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(),
                          color: const Color(0xf0EBEBEB)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextField(
                          obscureText: !_passwordVisible,
                          autocorrect: false,
                          controller: _controllerPass,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: const TextStyle(fontSize: 20),
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