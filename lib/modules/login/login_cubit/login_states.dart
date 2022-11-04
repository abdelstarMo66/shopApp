import 'package:shop_app/models/info_user_model.dart';

abstract class LoginStates {}

class InitialLoginState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel modelData;

  LoginSuccessState(this.modelData);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginChangeIconVisibility extends LoginStates {}
