import 'package:flutter/material.dart';

class MainBreakdown extends StatefulWidget{
  const MainBreakdown ({super.key});

  @override
  _MainBreakdown createState() => _MainBreakdown();
}
class _MainBreakdown extends State<MainBreakdown>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            color: const Color(0xf0ECE0D1).withAlpha(150),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const BackButton(),
                const Spacer(),
                Image.asset(
                  'assets/images/Logo_brown.png',
                  width: 130,
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

}