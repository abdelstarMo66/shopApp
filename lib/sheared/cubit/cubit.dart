import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favourite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categories.dart';
import 'package:shop_app/modules/favorites.dart';
import 'package:shop_app/modules/products.dart';
import 'package:shop_app/modules/settings.dart';
import 'package:shop_app/sheared/cubit/states.dart';
import 'package:shop_app/sheared/network/end_point.dart';
import 'package:shop_app/sheared/network/remote/dio_hekper.dart';

import '../../models/get_favorites_model.dart';
import '../../models/info_user_model.dart';
import '../constant/constant.dart';
import '../network/local/cashe_helper.dart';

class AppCubit extends Cubit<States> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool DarkMade = false;

  IconData DarkLightMode = Icons.brightness_4_outlined;

  void ChangeMode({bool? isDark}) {
    if (isDark != null) {
      DarkMade = isDark;
      emit(ChangeModeApp());
    } else {
      DarkMade = !DarkMade;
      CacheHelper.saveData(
        key: "DarkMode",
        value: DarkMade,
      ).then((value) {
        emit(ChangeModeApp());
      });
    }
    if (!DarkMade) {
      DarkLightMode = Icons.dark_mode_outlined;
      emit(IconChangeMode());
    } else {
      DarkLightMode = Icons.brightness_4_outlined;
      emit(IconChangeMode());
    }
  }

  int currentIndex = 0;

  List<Widget> Screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottomNavBar(index) {
    currentIndex = index;
    if (index == 3)
      getUserDataModel();
    else if (index == 2)
      GetDataFavModel();
    else if (index == 1) categoryModel();

    homeData();
    emit(ChangeBottomNavBarState());
  }

  List<BottomNavigationBarItem> Items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Prodects',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Category',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outlined),
      label: 'Favorites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Setting',
    ),
  ];

  HomeModel? homeModel;

  Map<int, dynamic>? favourite = {};

  void homeData() {
    emit(HomeLoadingState());

    DioHelper.getData(url: Home, token: token).then((value) {
      homeModel = HomeModel.fromjson(value.data);

      homeModel!.data!.products.forEach((element) {
        favourite!.addAll({
          element.id: element.inFavorites,
        });
      });
      emit(HomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorState());
    });
  }

  CategoriesModel? CategoryModel;

  void categoryModel() {
    emit(CategoriesLoadingState());

    DioHelper.getData(url: Categories).then((value) {
      CategoryModel = CategoriesModel.fromjson(value.data);
      emit(CategoriesSuccessState());
    }).catchError((error) {
      emit(CategoriesErrorState());
    });
  }

  LoginModel? GetUserData;

  void getUserDataModel() {
    emit(GetUserDataLoadingState());
    DioHelper.getData(url: Profile, token: token).then((value) {
      GetUserData = LoginModel.fromjson(value.data);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState());
    });
  }

  void updateUserDataModel({
    required String? name,
    required String? email,
    required String? phone,
  }) {
    emit(UpdateUserDataLoadingState());
    DioHelper.putData(
      url: Update_Profile,
      token: token,
      Query: {
        "name": "$name",
        "email": "$email",
        "phone": "$phone ",
      },
    ).then((value) {
      GetUserData = LoginModel.fromjson(value.data);
      emit(UpdateUserDataSuccessState(GetUserData!));
    }).catchError((error) {
      emit(UpdateUserDataErrorState());
    });
  }

  FavouriteModel? favouriteModel;

  void FavouriteData({@required int? ProdcctID}) {
    favourite![ProdcctID!] = !favourite![ProdcctID];

    emit(FavouriteSuccessState());

    DioHelper.postData(
      url: Favourite,
      Data: {'product_id': '$ProdcctID'},
      token: token,
    ).then((value) {
      favouriteModel = FavouriteModel.fromjson(value.data);
      Fluttertoast.showToast(
        msg: favouriteModel!.message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        fontSize: 16.0,
      );
      if (favouriteModel!.status == false) {
        favourite![ProdcctID] = !favourite![ProdcctID];
        Fluttertoast.showToast(
          msg: favouriteModel!.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          fontSize: 16.0,
        );
      } else {
        GetDataFavModel();
      }
      emit(FavouriteSuccessState());
    }).catchError((error) {
      favourite![ProdcctID] = !favourite![ProdcctID];
      Fluttertoast.showToast(
        msg: favouriteModel!.message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        fontSize: 16.0,
      );
      emit(FavouriteErrorState());
    });
  }

  GetFavoriteModel? favModel;

  void GetDataFavModel() {
    emit(GetFavoriteLoadingState());

    DioHelper.getData(
      url: GetFavourite,
      token: token,
    ).then((value) {
      favModel = GetFavoriteModel.fromJson(value.data);
      print(favModel!.data!.dataList[0].product!.name);
      emit(GetFavoriteSuccessState());
    }).catchError((error) {
      emit(GetFavoriteErrorState());
    });
  }
}
