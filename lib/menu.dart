import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Menu extends StatefulWidget{
  const Menu({super.key});

  @override
  _MenuState createState() => _MenuState();

}
class _MenuState extends State<Menu>{
  @override
  void initState(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom
    ]);  // to only hide the status bar
  }
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);  // to re-show bars
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 150,
            height: double.infinity,
            color: Colors.black12,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset(
                      'assets/images/Logo_brown.png'
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
              width: 600,
              height: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xf0634832),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: (){

                          },
                          child: const Text(
                            'Coffee',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        height: 50,
                        child: TextButton(
                          onPressed: (){

                          },
                          child: const Text(
                            'Signature Latte',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: TextButton(
                          onPressed: (){

                          },
                          child: const Text(
                            'Croffles',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 600,
                    height: double.infinity,
                    color: const Color(0xf0ECE0D1),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextField(

                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ),
        ],
      ),
    );
  }

}