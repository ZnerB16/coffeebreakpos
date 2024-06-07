import 'package:coffee_break_pos/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResponsiveLayout extends StatelessWidget{

  final Widget mobileBody;
  final Widget tabletBody;

  const ResponsiveLayout({
    super.key,
    required this.mobileBody,
    required this.tabletBody
  });

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
        builder: (context, constraints){
          if(constraints.maxWidth < 600){
            return mobileBody;
          }
          else{
            SystemChrome.setPreferredOrientations(
                [
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight
                ]
            );
            return tabletBody;
          }
        }
    );
  }
  
}