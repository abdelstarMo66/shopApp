import '../../models/info_user_model.dart';

abstract class States {}

class InitialState extends States {}

class ChangeBottomNavBarState extends States {}

class ChangeModeApp extends States {}

class IconChangeMode extends States {}

class HomeLoadingState extends States {}

class HomeSuccessState extends States {}

class HomeErrorState extends States {}

class CategoriesLoadingState extends States {}

class CategoriesSuccessState extends States {}

class CategoriesErrorState extends States {}

class GetUserDataLoadingState extends States {}

class GetUserDataSuccessState extends States {}

class GetUserDataErrorState extends States {}

class FavouriteSuccessState extends States {}

class FavouriteErrorState extends States {}

class UpdateUserDataLoadingState extends States {}

class UpdateUserDataSuccessState extends States {
  final LoginModel modelData;

  UpdateUserDataSuccessState(this.modelData);
}

class UpdateUserDataErrorState extends States {}

class GetFavoriteSuccessState extends States {}

class GetFavoriteLoadingState extends States {}

class GetFavoriteErrorState extends States {}
