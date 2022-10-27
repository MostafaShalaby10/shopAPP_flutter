class GetFavorites
{
  late final bool status ;
  late GetFavoritesData  data ;

  GetFavorites.fromjson(Map<dynamic , dynamic> json)
  {
    status = json['status'] ;
    data = GetFavoritesData.fromjson(json['data']) ;

  }
}
class GetFavoritesData
{
late List<DataOfFavoritesItem> Product_data = []  ;

GetFavoritesData.fromjson(Map<dynamic , dynamic> json)
{
  json['data'].forEach((element) {
    Product_data.add(DataOfFavoritesItem.fromjson(element));
  });
}

}

class DataOfFavoritesItem
{
  late DataOfProduct  product ;
  DataOfFavoritesItem.fromjson(Map<dynamic , dynamic>json)
  {
    product = DataOfProduct.fromjson(json['product']) ;
  }

}

class DataOfProduct
{
  late final int id ;
  late final dynamic price ;
  late final dynamic old_price ;
  late final dynamic discount ;
  late final String name ;
  late final String image ;


  DataOfProduct.fromjson(Map<dynamic , dynamic> json)
  {
    id = json['id'] ;
    image = json['image'] ;
    price = json['price'] ;
    old_price = json['old_price'] ;
    discount = json['discount'] ;
    name = json['name'] ;

  }
}

