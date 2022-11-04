class GetSearchModel {
  bool? status;
  Null? message;
  Data? data;

  GetSearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  List<Product> dataList = [];

  Data.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      dataList.add(Product.fromJson(element));
    });
  }
}

class Product {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  dynamic image;
  dynamic name;
  dynamic description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
