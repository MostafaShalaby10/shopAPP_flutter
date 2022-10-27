import 'package:shopapp1/models/LoginModel.dart';

abstract class ProductStates{}
class InitialProductState extends ProductStates{}
class changebottomsheetstate extends ProductStates{}
class ChangePassworvisiability extends ProductStates{}
class LoadingGetProducts extends ProductStates{}
class SuccessGetProducts extends ProductStates{}
class ErrorGetProducts extends ProductStates{}
class LoadingChangeFavorites extends ProductStates{}
class SuccessChangeFavorites extends ProductStates{}
class ErrorChangeFavorites extends ProductStates{}
class LoadingChangeCarts extends ProductStates{}
class SuccessChangeCarts extends ProductStates{}
class ErrorChangeCarts extends ProductStates{}
class LoadingGetFavorites extends ProductStates{}
class SuccessGetFavorites extends ProductStates{}
class ErrorGetFavorites extends ProductStates{}
class LoadingGetCarts extends ProductStates{}
class SuccessGetCarts extends ProductStates{}
class ErrorGetCarts extends ProductStates{}
class LoadingLoginModel extends ProductStates{}
class SuccessLoginModel extends ProductStates{}
class ErrorLoginModel extends ProductStates{}
class LoadingUserData extends ProductStates{}
class SuccessUserData extends ProductStates{}
class ErrorUserData extends ProductStates{}
class LoadingRegister extends ProductStates{}
class SuccessRegister extends ProductStates{
 final LoginModel Registermodel ;

  SuccessRegister(this.Registermodel);
}
class ErrorRegister extends ProductStates{}
class LoadingUpdate extends ProductStates{}
class SuccessUpdate extends ProductStates{}
class ErrorUpdate extends ProductStates{}
class LoadingLogin extends ProductStates{}
class SuccessLogin extends ProductStates{
  final LoginModel loginModel ;

  SuccessLogin(this.loginModel);
}
class ErrorLogin extends ProductStates{}