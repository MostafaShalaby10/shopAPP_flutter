class ProductModel
{
  late final bool status ;
  late final String message ;
  ProductModelData ?data ;
  ProductModel.fromjson(Map<dynamic , dynamic>json)
  {
    status = json['status'] ;
    message = json['message'] ;
    data = ProductModelData.fromjson(json['data']);

  }
}
class ProductModelData
{
  List<BannersData> banners =[] ;
  List<ProductsData> products =[] ;

  ProductModelData.fromjson(Map<dynamic , dynamic>json)
  {
    json['banners'].forEach((element) {
      banners.add(BannersData.fromjson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductsData.fromjson(element));
    });  }
}

class BannersData
{
    late final int id ;
    late final String image ;

    BannersData.fromjson(Map<dynamic , dynamic> json)
    {
      id = json['id'] ;
      image = json['image'] ;
    }

}

class ProductsData
{
  late final int id ;
  late final dynamic price ;
  late final dynamic old_price ;
  late final dynamic discount ;
  late final String name ;
  late final String image ;
  late final bool in_favorites ;
  late final bool in_cart ;

  ProductsData.fromjson(Map<dynamic , dynamic> json)
  {
    id = json['id'] ;
    image = json['image'] ;
    price = json['price'] ;
    old_price = json['old_price'] ;
    discount = json['discount'] ;
    name = json['name'] ;
    in_favorites = json['in_favorites'] ;
    in_cart = json['in_cart'] ;

  }
}