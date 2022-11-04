class FavouriteModel {
  bool? status;
  String? message;

  FavouriteModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
