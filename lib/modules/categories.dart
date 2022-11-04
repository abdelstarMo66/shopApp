import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/sheared/cubit/cubit.dart';

import '../models/categories_model.dart';
import '../sheared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, States>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) =>
              BuildCat(AppCubit.get(context).CategoryModel!.data!.data[index]),
          separatorBuilder: (context, index) => Container(
            height: 1.0,
            color: Colors.grey,
            padding: EdgeInsets.symmetric(horizontal: 5.0),
          ),
          itemCount: AppCubit.get(context).CategoryModel!.data!.data.length,
        );
      },
    );
  }

  Widget BuildCat(DataModelCat model) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 18.0,
            ),
            Text(
              '${model.name}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepOrange[300],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
}
