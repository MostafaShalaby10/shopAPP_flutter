import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp1/bloc/ProductCubit.dart';
import 'package:shopapp1/bloc/ProductStates.dart';
import 'package:shopapp1/pages/Login.dart';
import 'package:shopapp1/pages/home.dart';
import 'package:shopapp1/sharedprefrences/Sharedprefrences.dart';

class register extends StatelessWidget {
  var namecontroller = TextEditingController() ;
  var emailcontroller = TextEditingController() ;
  var phonecontroller = TextEditingController() ;
  var passwordcontroller = TextEditingController() ;
  var formkey = GlobalKey<FormState>() ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit , ProductStates>(
        builder: (context , state)
        {

          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (String ?value)
                        {
                          if(value!.isEmpty)
                            return "Name can't be empty!!" ;
                        },
                        controller: namecontroller,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        decoration: InputDecoration(
                            label: Text("Name"),
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                      ) ,
                      SizedBox(height: 20,) ,
                      TextFormField(
                        validator: (String ?value)
                        {
                          if(value!.isEmpty)
                            return "Email can't be empty!!" ;
                        },
                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        decoration: InputDecoration(
                            label: Text("Email"),
                            prefixIcon: Icon(Icons.mail),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                      ) ,
                      SizedBox(height: 20,) ,
                      TextFormField(
                        validator: (String ?value)
                        {
                          if(value!.isEmpty)
                            return "Password can't be empty!!" ;
                        },
                        controller: passwordcontroller,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: ProductCubit.get(context).ispassword,
                        decoration: InputDecoration(
                            label: Text("Password"),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: (){
                                ProductCubit.get(context).changepass();
                              } ,
                              icon: Icon(
                                  ProductCubit.get(context).icon
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                      ) ,
                      SizedBox(height: 20,) ,
                      TextFormField(
                        validator: (String ?value)
                        {
                          if(value!.isEmpty)
                            return "Phone can't be empty!!" ;
                        },
                        controller: phonecontroller,
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        decoration: InputDecoration(
                            label: Text("phone"),
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                      ) ,
                      SizedBox(height: 20,) ,


                      ConditionalBuilder(
                        builder: (context) =>Container(
                          width: double.infinity,
                          color: Colors.deepOrange,
                          height: 50,
                          child: MaterialButton(onPressed: (){

                            if(formkey.currentState!.validate())
                            {
                              ProductCubit.get(context).Register(
                                  name: namecontroller.text,
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text,
                                  phone: phonecontroller.text);
                            }
                            else
                            {
                              print("empty data !!") ;
                            }
                          }  ,
                            child: Text("Sign up"),),
                        ),
                          condition: state is ! LoadingRegister,
                        fallback: (context) =>Center(child: CircularProgressIndicator()),
                      )
                    ] ,),
                ),
              ),
            ),
          ) ;
        },
        listener: (context , state) {
          if (state is SuccessRegister)
          {
            if (state.Registermodel.status) {
              Fluttertoast.showToast(
                  msg: state.Registermodel.message,
                  backgroundColor: Colors.green,
                  toastLength: Toast.LENGTH_SHORT,
                  textColor: Colors.white,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1);
              sharedprefs.savedata(key: "token", value: state.Registermodel.data?.token)
                  .then((value) {
                if (value) {
                  Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) =>login())
                    , (route) => false , ) ;
                }
              });
            } else {
              Fluttertoast.showToast(
                  msg: state.Registermodel.message ,
                  backgroundColor: Colors.red,
                  toastLength: Toast.LENGTH_SHORT,
                  textColor: Colors.white,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1
              );
            }
          }
        });
  }
}
