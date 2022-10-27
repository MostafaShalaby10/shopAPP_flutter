import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp1/bloc/ProductCubit.dart';
import 'package:shopapp1/bloc/ProductStates.dart';

class products extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ProductCubit , ProductStates>(
          builder: (context , state)
          {
            return Scaffold(
              body: ConditionalBuilder(
                  condition: ProductCubit.get(context).productModel != null,
                  builder: (context) => SingleChildScrollView(
                    child: Column (
                      children: [
                        CarouselSlider(
                          items:  ProductCubit.get(context).productModel!.data!.banners
                              .map(
                                (e) => Image(
                              image: NetworkImage('${e.image}'),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                              .toList(),
                          options: CarouselOptions(
                            height: 150,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            viewportFraction: 1,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.4,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          children: List.generate(
                              ProductCubit.get(context).productModel!.data!.products.length,
                                  (index) => Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Stack(
                                        alignment:
                                        AlignmentDirectional.bottomStart,
                                        children: [
                                          Image(
                                            image: NetworkImage(
                                                "${ProductCubit.get(context).productModel!.data!.products[index].image}"),
                                            height: 120,
                                            // fit: BoxFit.cover,
                                          ),
                                          if (ProductCubit.get(context).productModel!
                                              .data!
                                              .products[index]
                                              .discount !=
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
                                      height: 5,
                                    ),
                                    Text(
                                      "${ProductCubit.get(context).productModel!.data!.products[index].name}",
                                      maxLines: 2,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          "${ProductCubit.get(context).productModel!.data!.products[index].price}",
                                          style: Theme.of(context).textTheme.bodyText1,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        if (ProductCubit.get(context).productModel!
                                            .data!
                                            .products[index]
                                            .discount !=
                                            0)
                                          Text(
                                            "${ProductCubit.get(context).productModel!.data!.products[index].old_price}",
                                            style: Theme.of(context).textTheme.bodyText1,
                                          ),
                                        Spacer(),
                                          Expanded(
                                            child: IconButton(onPressed: (){
                                              ProductCubit.get(context).changeFavorites(ProductCubit.get(context).productModel!.data!.products[index].id) ;
                                            },
                                                icon: Icon(
                                                  ProductCubit.get(context).favoritesProducts[ProductCubit.get(context).productModel!.data!.products[index].id] ? Icons.favorite : Icons.favorite_border_outlined
                                                ) , ),
                                          ) ,
                                          Expanded(
                                            child: IconButton(onPressed: (){
                                              ProductCubit.get(context).changeCart(ProductCubit.get(context).productModel!.data!.products[index].id) ;
                                            },
                                                icon: Icon(
                                                  ProductCubit.get(context).cartProducts[ProductCubit.get(context).productModel!.data!.products[index].id] ? Icons.shopping_cart : Icons.shopping_cart_outlined
                                                ) , ),
                                          ) ,
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ) ,

              fallback: (context) => Center(child: CircularProgressIndicator()),),
            ) ;
          },
          listener: (context , state){});

  }
}
