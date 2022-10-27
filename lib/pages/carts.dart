import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp1/bloc/ProductCubit.dart';
import 'package:shopapp1/bloc/ProductStates.dart';
class carts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ProductCubit.get(context).getCarts != null,
            builder: (context)
            {
              if(ProductCubit.get(context)
                  .getCarts!
                  .data!
                  .Product_data
                  .length >0)
              {
                return Scaffold(
                  body: ListView.separated(
                    itemBuilder: (context, index) =>  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                            alignment:
                            AlignmentDirectional.bottomStart,
                            children: [
                              Image(
                                image: NetworkImage(
                                    "${ProductCubit.get(context).getCarts!.data!.Product_data[index].product!.image}"),
                                height: 120,
                                fit: BoxFit.cover,
                                // fit: BoxFit.cover,
                              ),
                              if (ProductCubit.get(context).getCarts!.data!.Product_data[index].product!.discount !=
                                  0)
                                Container(
                                  color: Colors.red,
                                  child: Text(
                                    "Discount",
                                    style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.white),
                                  ),
                                )
                            ]),
                        SizedBox(
                          width: 2,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${ProductCubit.get(context).getCarts!.data!.Product_data[index].product!.name}",
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodyText1 ,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Spacer(),
                              Row(
                                children: [
                                  Text(
                                    "${ProductCubit.get(context).getCarts!.data!.Product_data[index].product!.price}",
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  if (ProductCubit.get(context).getCarts!
                                      .data!
                                      .Product_data[index].product!.discount!=
                                      0)
                                    Text(
                                      "${ProductCubit.get(context).getCarts!.data!.Product_data[index].product!.old_price}",
                                      style: Theme.of(context).textTheme.bodyText1
                                    ),

                                ],
                              ),
                            ],),
                        )

                      ],
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                    itemCount: ProductCubit.get(context)
                        .getCarts!
                        .data!
                        .Product_data
                        .length,
                  ),
                ) ;
              }else
              {
                return Scaffold(
                  body: Center(child: Text("There is no data"),),
                );
              }
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );


        },
        listener: (context, state) {});
  }
}
