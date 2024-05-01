import 'package:flutter/material.dart';

import 'custom_rect_tween.dart';

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

  @override
  Widget build(BuildContext context) {
    return Center(
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
                height: 450,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      const Text(
                          "New Employee Form",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 280,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
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
                                        hintStyle: TextStyle(fontSize: 16),
                                    ),
                                    style: const TextStyle(
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 20)),
                              Container(
                                width: 280,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(),
                                    color: const Color(0xf0EBEBEB)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: TextField(
                                    autocorrect: false,
                                    controller: _controllerAddress,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Address',
                                      hintStyle: TextStyle(fontSize: 16),
                                    ),
                                    style: const TextStyle(
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 20)),
                              Container(
                                width: 280,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(),
                                    color: const Color(0xf0EBEBEB)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: TextField(
                                    autocorrect: false,
                                    controller: _controllerBD,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Birthdate',
                                      hintStyle: TextStyle(fontSize: 16),
                                      prefixIcon: Icon(Icons.calendar_today)
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
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
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