import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp1/Components.dart';
import 'package:shopapp1/bloc/ProductStates.dart';
import 'package:shopapp1/dio/dio.dart';
import 'package:shopapp1/models/ChangeCartModel.dart';
import 'package:shopapp1/models/ChangeFavoritesModel.dart';
import 'package:shopapp1/models/GetCarts.dart';
import 'package:shopapp1/models/GetFavorites.dart';
import 'package:shopapp1/models/LoginModel.dart';
import 'package:shopapp1/models/productModel.dart';
import 'package:shopapp1/pages/carts.dart';
import 'package:shopapp1/pages/favorites.dart';
import 'package:shopapp1/pages/products.dart';
import 'package:shopapp1/pages/settings.dart';

class ProductCubit extends Cubit<ProductStates>
{
  ProductCubit() : super(InitialProductState()) ;
  static ProductCubit get(context) => BlocProvider.of(context) ;
bool ispassword = true ;
IconData icon = Icons.visibility ;
  int current_index = 0 ;
  List<BottomNavigationBarItem> items =
  [
    BottomNavigationBarItem(icon: Icon(Icons.home) , label: "Home") ,
    BottomNavigationBarItem(icon: Icon(Icons.favorite_sharp) , label: "Favorites") ,
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart) , label: "Cart") ,
    BottomNavigationBarItem(icon: Icon(Icons.settings) , label: "Settings") ,
  ] ;
  List pages = [products() , favorites() , carts() , settings()] ;

  void changebottom(int index)
  {
    current_index = index ;
    emit(changebottomsheetstate()) ;
  }


  ProductModel ? productModel ;
  ChangeFavoritesModel ? changeFavoritesModel ;
  ChangeCartModel ? changeCartModel ;
  GetFavorites ? getFavorites ;
  LoginModel ? loginModel ;
  LoginModel ? userModel ;
  LoginModel ? UpdateModel ;
  LoginModel ? RegisterModel ;
  GetCarts ? getCarts ;
  Map<dynamic , dynamic> favoritesProducts ={} ;
  Map<dynamic , dynamic> cartProducts ={} ;

  void changepass()
  {
    ispassword = !ispassword ;

    if(ispassword)
      {
        icon = Icons.visibility ;
      }else
        {
          icon = Icons.visibility_off ;

        }
    emit(ChangePassworvisiability()) ;
  }
  void login({required String email, required String password}) {
    emit(LoadingLogin());
    api_test.post(
        url: 'login',
        data: {'email': email, 'password': password}).then((value) {
      loginModel = LoginModel.fromjson(value.data);
      print(loginModel!.status);
      print(loginModel!.message);
      print(loginModel!.data);
      token = loginModel!.data!.token ;
      print("From cubit" + token);
      GetProducts();
      Getcart() ;
      Getfav() ;
      UserData() ;
      emit(SuccessLogin(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorLogin());
    });
  }


  void GetProducts()
  {
    // UserData() ;
   emit(LoadingGetProducts()) ;
   api_test.get(
       url: "home" ,
      token: token ,
   ).then((value)
   {
     productModel = ProductModel.fromjson(value.data) ;
     productModel!.data!.products.forEach((element) {
       favoritesProducts.addAll({
         element.id : element.in_favorites
       }) ;
       cartProducts.addAll({
         element.id : element.in_cart
       }) ;
     }) ;
     print(favoritesProducts.toString()) ;
     print(cartProducts.toString()) ;
     emit(SuccessGetProducts()) ;
   }).catchError((error){
     print(error.toString()) ;
     emit(ErrorGetProducts()) ;
   }) ;
  }
  void Getfav()
  {
   emit(LoadingGetFavorites()) ;
   api_test.get(
       url: "favorites" ,
      token: token ,
   ).then((value)
   {
     getFavorites = GetFavorites.fromjson(value.data) ;
     // print(getFavorites!.data.Product_data[0].product.name);
     print(getFavorites);
     print(getFavorites.toString());
     print(getFavorites!.data.Product_data.length);
     emit(SuccessGetFavorites()) ;
   }).catchError((error){
     print(error.toString()) ;
     emit(ErrorGetFavorites()) ;
   }) ;
  }


  void Register({required String name, required String email, required String password, required String phone , }) {
    emit(LoadingRegister());
    api_test.post(
        url: 'register',
        data: {
          "email": email,
          "password": password,
          "name" : name,
          "phone" : phone ,
        },
    ).then((value) {
      print("okkkkkkk") ;
      print(value.data) ;
      RegisterModel = LoginModel.fromjson(value.data);
      // token = RegisterModel!.data!.token ;
      // UserData() ;
      emit(SuccessRegister(RegisterModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorRegister());
    });
  }


  void UserData() {
    emit(LoadingUserData());
    api_test.get(
      url: 'profile',
      token: token ,
    ).then((value) {
      print("1") ;
      userModel = LoginModel.fromjson(value.data);
      print(userModel!.data!.name) ;
      emit(SuccessUserData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUserData());
    });
  }


  void UpdateData({required String name, required String email,  String password ="", required String phone , }) {
    emit(LoadingUpdate());
    if(password != "")
      {
        api_test.put(
          url: 'update-profile',
          data:
          {
            "name": name,
            "phone": phone,
            "email": email,
            "password": password,
          },
          token: token ,
        ).then((value) {
          UpdateModel = LoginModel.fromjson(value.data);
          print("if") ;
UserData();
          emit(SuccessUpdate());
        }).catchError((error) {
          print(error.toString());
          emit(ErrorUpdate());
        });
      }else
        {
          api_test.put(
            url: 'update-profile',
            data:
            {
              "name": name,
              "phone": phone,
              "email": email,
            },
            token: token ,
          ).then((value) {
            UpdateModel = LoginModel.fromjson(value.data);
            UserData();
            print("else") ;
            emit(SuccessUpdate());
          }).catchError((error) {
            print(error.toString());
            emit(ErrorUpdate());
          });
        }

  }


  void Getcart()
  {
   emit(LoadingGetCarts()) ;
   api_test.get(
       url: "carts" ,
      token: token ,
   ).then((value)
   {
     getCarts = GetCarts.fromjson(value.data) ;
     // print(getFavorites!.data.Product_data[0].product.name);
     print(getCarts);
     print(getCarts.toString());
     print(getCarts!.data.Product_data.length);
     emit(SuccessGetCarts()) ;
   }).catchError((error){
     print(error.toString()) ;
     emit(ErrorGetCarts()) ;
   }) ;
  }

  void changeFavorites(int productId)
  {
    favoritesProducts[productId] = ! favoritesProducts[productId] ;
    emit(LoadingChangeFavorites()) ; 
    api_test.post(
        url: "favorites",
        data: {"product_id" : productId}  ,
      token: token ,
    ) .then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromjson(value.data) ;
      if(!(changeFavoritesModel!.status))
        {
          favoritesProducts[productId] = ! favoritesProducts[productId] ;
        }
      else
        {
          Getfav() ;
        }
      print(changeFavoritesModel!.message) ;
      emit(SuccessChangeFavorites()) ;
    }).catchError((error)
    {
      print(error.toString()) ;
      emit(ErrorChangeFavorites()) ;

    });
  }
  void changeCart(int productId)
  {
    cartProducts[productId] = ! cartProducts[productId] ;
    emit(LoadingChangeCarts()) ;
    api_test.post(
      url: "carts",
      data: {"product_id" : productId}  ,
      token: token ,
    ) .then((value)
    {
      changeCartModel = ChangeCartModel.fromjson(value.data) ;
      if(!(changeCartModel!.status))
      {
        cartProducts[productId] = ! cartProducts[productId] ;
      }else
        {
          Getcart() ;
        }
      print(changeCartModel!.message) ;
      emit(SuccessChangeCarts()) ;
    }).catchError((error)
    {
      print(error.toString()) ;
      emit(ErrorChangeCarts()) ;

    });
  }
}