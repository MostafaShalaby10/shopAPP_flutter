import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lighttheme = ThemeData(
  scaffoldBackgroundColor: Colors.white ,
  appBarTheme: AppBarTheme(
    color: Colors.deepOrange,
    backwardsCompatibility: false ,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.deepOrange ,
      statusBarIconBrightness: Brightness.light
    ),
    titleTextStyle: TextStyle(
      fontSize: 18  ,
      fontWeight: FontWeight.bold ,
      color: Colors.white
    ) ,
  ) ,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18 ,
      color: Colors.black ,
    )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed ,
    selectedItemColor: Colors.deepOrange ,
    unselectedItemColor: Colors.black
  ) ,
  buttonTheme: ButtonThemeData(
      buttonColor: Colors.deepOrange
  ),
  listTileTheme: ListTileThemeData(
    textColor: Colors.black ,
  )
) ;






ThemeData darktheme = ThemeData(
  scaffoldBackgroundColor: Colors.black ,
  appBarTheme: AppBarTheme(
    color: Colors.black,
    backwardsCompatibility: false ,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black ,
      statusBarIconBrightness: Brightness.light
    ),
    titleTextStyle: TextStyle(
      fontSize: 18  ,
      fontWeight: FontWeight.bold ,
      color: Colors.white

    ) ,
  ) ,
    textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 18 ,
          color: Colors.white ,
        )
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.grey
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    type: BottomNavigationBarType.fixed ,
    selectedItemColor: Colors.deepOrange ,
    unselectedItemColor: Colors.white
  ) ,
    listTileTheme: ListTileThemeData(
      textColor: Colors.green ,
    )
) ;