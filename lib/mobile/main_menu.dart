import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget{
  const MainMenu ({super.key});

  @override
  _MainMenuState createState() => _MainMenuState();
}
class _MainMenuState extends State<MainMenu>{
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: const Color(0xf0ECE0D1).withAlpha(150),
        title: Row(
          children: [
            IconButton(
                onPressed: (){

                },
                icon: const Icon(
                  Icons.menu,
                  color: Color(0xf0634832)
                )
            ),
            const Spacer(),
            Image.asset(
                'assets/images/Logo_brown.png',
              width: 130,
            ),
            const Spacer(flex: 2,),
          ],
        ),
      ),
      body: Column(
        children: [

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(color: Color(0xf0634832)),
        onTap: (int newIndex){
          _currentIndex = newIndex;
        },
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home, color: Color(0xf0634832),),
          ),
          BottomNavigationBarItem(
              label: "Cart",
              icon: Icon(Icons.shopping_cart),
              activeIcon: Icon(Icons.shopping_cart, color: Color(0xf0634832),),
          ),
          BottomNavigationBarItem(
              label: "Order List",
              icon: Icon(
                  Icons.dashboard,
              ),
              activeIcon: Icon(Icons.dashboard, color: Color(0xf0634832),),
          ),
        ],
      ),
    );
  }

}