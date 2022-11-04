import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/search_cubit/search_cubit.dart';
import 'package:shop_app/modules/search/search_cubit/search_states.dart';
import 'package:shop_app/sheared/componant/text_form_field.dart';

import '../../sheared/componant/list_product.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchColtroler = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              padding: EdgeInsets.all(12.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    FormText(
                      context,
                      hintText: "Search",
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Enter Text For Search";
                        }
                        return null;
                      },
                      control: searchColtroler,
                      type: TextInputType.text,
                      prefix: Icons.search_rounded,
                      submit: (value) {
                        SearchCubit.get(context).SearchModel(value);
                      },
                      change: (value) {
                        SearchCubit.get(context).SearchModel(value);
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 15.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => BuildListProduct(
                              SearchCubit.get(context)
                                  .searchModel!
                                  .data!
                                  .dataList[index],
                              context),
                          separatorBuilder: (context, index) => Container(
                            height: 1.0,
                            color: Colors.grey,
                          ),
                          itemCount: SearchCubit.get(context)
                              .searchModel!
                              .data!
                              .dataList
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
