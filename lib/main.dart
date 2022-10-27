import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp1/Components.dart';
import 'package:shopapp1/bloc/ProductCubit.dart';
import 'package:shopapp1/bloc/ProductStates.dart';
import 'package:shopapp1/dio/dio.dart';
import 'package:shopapp1/pages/Login.dart';
import 'package:shopapp1/pages/Onboarding.dart';
import 'package:shopapp1/pages/home.dart';
import 'package:shopapp1/sharedprefrences/Sharedprefrences.dart';
import 'package:shopapp1/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  api_test.init();
  await sharedprefs.init();
  bool isboarding = sharedprefs.getdata(key: "onboarding");
  token = sharedprefs.getdata(key: "token");
  print("from main $token") ;
  bool flag = false ;
  print(flag) ;
  if (isboarding == null) {
    runApp(MyApp(
      isboard: isboarding,
      start: onboarding(),
      flag: flag,
    ));
  } else {
    if (token == null) {
      runApp(MyApp(
        isboard: isboarding,
        start: login(),
        flag: flag,
      ));
    } else {
      flag = true ;
      runApp(MyApp(
        isboard: isboarding,
        start: home(),
        flag: flag,
      ));
    }
  }
}

class MyApp extends StatelessWidget {
  final bool isboard;
final bool flag ;
  final Widget start;

  MyApp({required this.isboard, required this.start , required this.flag});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(flag)
     {
       return BlocProvider(
         create: (BuildContext context) => ProductCubit()..GetProducts()..Getfav()..Getcart()..UserData(),
         child: BlocConsumer<ProductCubit, ProductStates>(
             builder: (context, state) {
               return MaterialApp(
                 theme: lighttheme,
                 themeMode: ThemeMode.light,
                 debugShowCheckedModeBanner: false,
                 home: start,
               );
             },
             listener: (context, state) {}),
       );

     }else
       {
         return BlocProvider(
           create: (BuildContext context) => ProductCubit(),
           child: BlocConsumer<ProductCubit, ProductStates>(
               builder: (context, state) {
                 return MaterialApp(
                   theme: lighttheme,
                   themeMode: ThemeMode.light,
                   debugShowCheckedModeBanner: false,
                   home: start,
                 );
               },
               listener: (context, state) {}),
         );

       }
  }
}
