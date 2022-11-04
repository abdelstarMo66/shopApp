import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/info_user_model.dart';
import 'package:shop_app/modules/register/register_cubit/register_states.dart';
import 'package:shop_app/sheared/network/end_point.dart';
import 'package:shop_app/sheared/network/remote/dio_hekper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterState());

  RegisterModel? dataModel;

  static RegisterCubit get(context) => BlocProvider.of(context);

  void RegisterUser({
    required String? email,
    required String? password,
    required String? name,
    required String? phone,
  }) {
    emit(RegisterLoadingState());

    DioHelper.postData(
      url: Register,
      Data: {
        "email": "$email",
        "password": "$password",
        "name": "$name",
        "phone": "$phone",
      },
    ).then((value) {
      dataModel = RegisterModel.fromjson(value.data);
      print(dataModel!.message);
      emit(RegisterSuccessState(dataModel!));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  bool showPassword = true;
  Icon suffix = Icon(Icons.visibility_outlined);

  void changevisibility() {
    showPassword = !showPassword;
    suffix = showPassword
        ? Icon(Icons.visibility_outlined)
        : Icon(Icons.visibility_off_outlined);
    emit(RegisterChangeIconVisibility());
  }
}
