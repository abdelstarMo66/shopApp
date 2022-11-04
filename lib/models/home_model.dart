class HomeModel {
  bool? status;
  DataModel? data;

  HomeModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromjson(json['data']);
  }
}

class DataModel {
  List<bannerData> banners = [];
  List<productData> products = [];

  DataModel.fromjson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(bannerData.fromjson(element));
    });
    json['products'].forEach((element) {
      products.add(productData.fromjson(element));
    });
  }
}

class bannerData {
  int? id;
  String? image;

  bannerData.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class productData {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  dynamic inFavorites;
  bool? inCart;

  productData.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
