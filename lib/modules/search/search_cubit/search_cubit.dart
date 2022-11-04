import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/search_cubit/search_states.dart';
import 'package:shop_app/sheared/constant/constant.dart';
import 'package:shop_app/sheared/network/end_point.dart';
import 'package:shop_app/sheared/network/remote/dio_hekper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  GetSearchModel? searchModel;

  void SearchModel(String? search) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: Search,
      Data: {'text': '${search}'},
      token: token,
    ).then((value) {
      searchModel = GetSearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
