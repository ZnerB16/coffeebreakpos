import 'package:flutter/material.dart';

class CoffeeMenu extends StatefulWidget{
  const CoffeeMenu ({super.key});

  @override
  _CoffeeMenuState createState() => _CoffeeMenuState();
}
class _CoffeeMenuState extends State<CoffeeMenu>{

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xf0ECE0D1),
      child: SizedBox(
        width: 620,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: 300,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white
                      ),
                      child: const TextField(
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    )
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xf0634832),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              )
                            ],
                        ),
                        child: TextButton(
                          onPressed: (){

                          },
                          child: const Text(
                            'Iced',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 15)),
                      Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xf0ECE7DF),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              )
                            ]
                        ),
                        child: TextButton(
                          onPressed: (){

                          },
                          child: const Text(
                            'Hot',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ],
            )
          ],
        ),
      )
    );
  }

}