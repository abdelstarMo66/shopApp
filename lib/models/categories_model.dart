class CategoriesModel {
  bool? status;
  DataCategoriesModel? data;

  CategoriesModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataCategoriesModel.fromjson(json['data']);
  }
}

class DataCategoriesModel {
  int? currentPage;
  List<DataModelCat> data = [];

  DataCategoriesModel.fromjson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModelCat.fromjson(element));
    });
  }
}

class DataModelCat {
  int? id;
  String? name;
  String? image;

  DataModelCat.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
