import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/sheared/cubit/cubit.dart';
import 'package:shop_app/sheared/cubit/states.dart';

import '../sheared/componant/list_product.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, States>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).favourite !=null,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => BuildListProduct(
                AppCubit.get(context).favModel!.data!.dataList[index].product,
                context),
            separatorBuilder: (context, index) => Container(
              height: 1.0,
              color: Colors.grey,
            ),
            itemCount: AppCubit.get(context).favModel!.data!.dataList.length,
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
