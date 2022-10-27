class GetCarts
{
  late final bool status ;
  late GetCartsData  data ;

  GetCarts.fromjson(Map<dynamic , dynamic> json)
  {
    status = json['status'] ;
    data = GetCartsData.fromjson(json['data']) ;

  }
}
class GetCartsData
{
  late List<DataOfCartsItem> Product_data = []  ;

  GetCartsData.fromjson(Map<dynamic , dynamic> json)
  {
    json['cart_items'].forEach((element) {
      Product_data.add(DataOfCartsItem.fromjson(element));
    });
  }

}

class DataOfCartsItem
{
  late final int quantity ;

  late DataOfProduct  product ;
  DataOfCartsItem.fromjson(Map<dynamic , dynamic>json)
  {
    quantity = json['quantity'] ;
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

