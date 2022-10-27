import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp1/bloc/ProductCubit.dart';
import 'package:shopapp1/bloc/ProductStates.dart';
import 'package:shopapp1/pages/Login.dart';
import 'package:shopapp1/pages/Update.dart';
import 'package:shopapp1/sharedprefrences/Sharedprefrences.dart';

class settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit , ProductStates>(
        builder: (context , state)
        {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: [
                    Row (
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child:Icon(
                            Icons.person ,
                            size: 50,
                          ),
                        ) ,
                        SizedBox(width: 10,) ,
                        Text(
                          ProductCubit.get(context).userModel!.data!.name ,
                          style:  Theme.of(context).textTheme.bodyText1,
                        ) ,
                        Spacer() ,
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> update())) ;
                        },
                            icon: Icon(
                              Icons.edit
                            ))
                      ],
                    ),
                    SizedBox(height: 20,) ,

                    Container(
                      width: double.infinity,
                        height: 50,
                      color: Colors.deepOrange,
                        child: MaterialButton (
                            onPressed: ()
                        {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>login()), (route) => false);
                          sharedprefs.removedata(key: "token") ;
                        } ,
                          child: Text(
                              "Sign out" ,
                          style: Theme.of(context).textTheme.bodyText1,),
                        ) ,
                    )
                  ],
                ),
              ),
            ),
          ) ;
        },
        listener: (context , state){});
  }
}
