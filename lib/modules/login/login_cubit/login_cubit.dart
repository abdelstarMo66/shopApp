import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/info_user_model.dart';
import 'package:shop_app/modules/login/login_cubit/login_states.dart';
import 'package:shop_app/sheared/network/end_point.dart';
import 'package:shop_app/sheared/network/remote/dio_hekper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginState());

  LoginModel? dataModel;

  static LoginCubit get(context) => BlocProvider.of(context);

  void loginUser({
    required String? email,
    required String? password,
  }) {
    emit(LoginLoadingState());

    DioHelper.postData(
      url: Login,
      Data: {
        "email": "$email",
        "password": "$password",
      },
    ).then((value) {
      dataModel = LoginModel.fromjson(value.data);
      print(dataModel!.message);
      emit(LoginSuccessState(dataModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  bool showPassword = true;
  Icon suffix = Icon(Icons.visibility_outlined);

  void changevisibility() {
    showPassword = !showPassword;
    suffix = showPassword
        ? Icon(Icons.visibility_outlined)
        : Icon(Icons.visibility_off_outlined);
    emit(LoginChangeIconVisibility());
  }
}
