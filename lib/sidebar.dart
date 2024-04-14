import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget{
  const Sidebar({super.key});

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar>{
  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 20,
        child: SizedBox(
            width: 150,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  children: [
                    Image.asset(
                      'assets/images/Logo_brown.png',
                      width: 100,
                    ),
                    const Padding(padding: EdgeInsets.only(top:30)),
                    Container(
                      width: 60,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xf0ECE0D1),
                      ),

                      child: IconButton(
                        onPressed: (){

                        },
                        icon: Image.asset(
                          'assets/images/home.png',
                          width: 40,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top:30)),
                    Container(
                      width: 60,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: IconButton(
                        onPressed: (){

                        },
                        icon: Image.asset(
                          'assets/images/data-analysis.png',
                          width: 40,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top:30)),
                    Container(
                      width: 60,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: IconButton(
                        onPressed: (){

                        },
                        icon: Image.asset(
                          'assets/images/editing.png',
                          width: 40,
                        ),
                      ),
                    ),
                  ]
              ),
            )
        ),
      );
  }

}