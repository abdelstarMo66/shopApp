import 'package:shop_app/models/info_user_model.dart';

abstract class RegisterStates {}

class InitialRegisterState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final RegisterModel modelData;

  RegisterSuccessState(this.modelData);
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterChangeIconVisibility extends RegisterStates {}
