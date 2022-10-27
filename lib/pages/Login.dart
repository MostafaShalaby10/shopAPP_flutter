import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp1/bloc/ProductCubit.dart';
import 'package:shopapp1/bloc/ProductStates.dart';
import 'package:shopapp1/pages/Register.dart';
import 'package:shopapp1/pages/home.dart';
import 'package:shopapp1/sharedprefrences/Sharedprefrences.dart';


class login extends StatelessWidget {
  var emailtxt = TextEditingController();
  var passtxt = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
        builder: (context, state) =>
            Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Login",
                                style: Theme.of(context).textTheme.bodyText1),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              validator: (String ?value)
                              {
                                if(value!.isEmpty)
                                  return "Email can't be empty!!" ;
                              },
                              controller: emailtxt,
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
                              controller: passtxt,
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
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              child: ConditionalBuilder(
                                condition: state is! LoadingLogin,
                                builder: (context) =>
                                    MaterialButton(
                                      color: Colors.deepOrange,
                                      onPressed: () {
                                        if (formkey.currentState!.validate()) {
                                          ProductCubit.get(context).login(
                                              email: emailtxt.text,
                                              password: passtxt.text);
                                        }
                                      },
                                      child: Text(
                                        "Login",
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                    ),
                                fallback: (context) =>
                                    Center(
                                      child: CircularProgressIndicator(),
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Don\'t have an account",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>register())) ;
                                  },
                                  child: Text(
                                    "Create account",
                                    style: TextStyle(
                                      fontSize: 18 ,
                                      color: Colors.blue ,
                                    )
                                  ),
                                )
                              ],
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            ),
        listener: (context, state) {
          if (state is SuccessLogin) {
            if (state.loginModel.status) {
              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  backgroundColor: Colors.green,
                  toastLength: Toast.LENGTH_SHORT,
                  textColor: Colors.white,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1);
              sharedprefs.savedata(key: "token", value: state.loginModel.data?.token)
                  .then((value) {
                if (value) {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) =>home())
                    , (route) => false , ) ;
                }
              });
            } else {
              Fluttertoast.showToast(
                  msg: state.loginModel.message ,
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
