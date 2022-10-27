class ChangeCartModel
{
  late final bool status ;
  late final String message ;

  ChangeCartModel.fromjson(Map <dynamic , dynamic> json)
  {
    status = json['status'];
    message = json['message'];
  }
}