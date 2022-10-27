import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp1/bloc/ProductCubit.dart';
import 'package:shopapp1/bloc/ProductStates.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit , ProductStates>(
        builder: (context , state)
        {
          return Scaffold(
            appBar: AppBar(),
            bottomNavigationBar: BottomNavigationBar(

              items: ProductCubit.get(context).items,
              currentIndex: ProductCubit.get(context).current_index,
              onTap: (int index)
              {
                ProductCubit.get(context).changebottom(index) ;
              },
            ) ,
            body: ProductCubit.get(context).pages[ProductCubit.get(context).current_index],
          ) ;
        },
        listener: (context , state){});
  }
}
