import 'package:coffee_break_pos/breakdown/main_breakdown.dart';
import 'package:coffee_break_pos/hero_dialog_route.dart';
import 'package:coffee_break_pos/menu.dart';
import 'package:coffee_break_pos/order_list/orders_today.dart';
import 'package:coffee_break_pos/employee/password_hero.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget{
  String currentScreen = "";
  Sidebar({
    super.key,
    required this.currentScreen
  });

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar>{
  bool isHome = true;
  bool isOL = false;
  bool isTM = false;
  bool isBD = false;
  bool isED = false;

  @override
  void initState(){
    super.initState();
    checkCurrentScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 20,
        child: SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                  children: [
                    Image.asset(
                      'assets/images/Logo_brown.png',
                      width: 130,
                    ),
                    const Padding(padding: EdgeInsets.only(top:30)),
                    Container(
                      width: 60,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isHome ? const Color(0xf0ECE0D1): Colors.white,
                      ),

                      child: IconButton(
                        onPressed: (){
                          checkCurrentScreen();

                          if (widget.currentScreen != "Home") {
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context){
                                      return const Menu();
                                    })
                            );
                          }
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
                          color: isOL ? const Color(0xf0ECE0D1): Colors.white
                      ),

                      child: IconButton(
                        onPressed: (){
                          checkCurrentScreen();
                          if (widget.currentScreen != "OL") {
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context){
                                      return const OrdersTodayScreen();
                                    }
                                )
                            );
                          }
                        },
                        icon: Image.asset(
                          'assets/images/to-do-list.png',
                          width: 40,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top:120)),
                    Container(
                      width: 60,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                          color: isTM ? const Color(0xf0ECE0D1): Colors.white
                      ),

                      child: IconButton(
                        onPressed: (){
                          checkCurrentScreen();
                          if (widget.currentScreen != "TM") {
                            Navigator.push(
                                context,
                                HeroDialogRoute(
                                builder: (context){
                                  return PasswordHeroScreen();
                                }
                                )
                            );
                          }
                        },
                        icon: Image.asset(
                          'assets/images/back-in-time.png',
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
                          color: isBD ? const Color(0xf0ECE0D1): Colors.white
                      ),

                      child: IconButton(
                        onPressed: (){
                          checkCurrentScreen();
                          if (widget.currentScreen != "BD") {
                            Navigator.push(
                                context,
                                HeroDialogRoute(
                                    builder: (context){
                                      return BreakdownScreen();
                                    }
                                )
                            );
                          }
                        },
                        icon: Image.asset(
                          'assets/images/data-analysis.png',
                          width: 40,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    Container(
                        width: 60,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                            color: isED ? const Color(0xf0ECE0D1): Colors.white
                        ),

                        child: IconButton(
                          onPressed: (){
                            checkCurrentScreen();
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
  void checkCurrentScreen(){
    setState(() {
      if(widget.currentScreen == "Home"){
          isHome = true;
          isOL = false;
          isTM = false;
          isBD = false;
          isED = false;
      }
      else if(widget.currentScreen == "OL"){
          isHome = false;
          isOL = true;
          isTM = false;
          isBD = false;
          isED = false;
      }
      else if(widget.currentScreen == "TM"){
          isHome = false;
          isOL = false;
          isTM = true;
          isBD = false;
          isED = false;
      }
      else if(widget.currentScreen == "BD"){
          isHome = false;
          isOL = false;
          isTM = false;
          isBD = true;
          isED = false;
      }
      else if(widget.currentScreen == "ED"){
          isHome = false;
          isOL = false;
          isTM = false;
          isBD = false;
          isED = true;
      }
    });
  }
}