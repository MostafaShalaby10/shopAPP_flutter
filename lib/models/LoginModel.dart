class LoginModel
{
  late final bool status ;
  late final String message ;
  loginData? data ;
  LoginModel.fromjson( dynamic json)
  {
    status = json['status'] ;
    message = json['message'] ;
    data  = json['data'] !=null ? loginData.fromjson(json['data']) : null ;
  }
}

class loginData
{
  late final int id ;
  late final String name ;
  late final String email ;
  late final String phone ;
  late final String image ;
  late final int points ;
  late final int credit ;
  late final String token ;
  loginData.fromjson( dynamic json)
  {
    id = json['id'];
    name = json['name'] ;
    email = json['email'] ;
    phone = json['phone'] ;
    image = json['image'] ;
    points = json['points'] ;
    credit = json['credit'] ;
    token = json['token'] ;
  }
}