import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/search.dart';
import 'package:shop_app/sheared/cubit/cubit.dart';

import '../modules/login/login.dart';
import '../sheared/componant/navigate.dart';
import '../sheared/cubit/states.dart';
import '../sheared/network/local/cashe_helper.dart';

class Shop_layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, States>(
      listener: (context, state) {},
      builder: (context, state) {
        var cupit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: cupit.currentIndex == 3
                ? Text('MONTAGY')
                : Center(child: Text('MONTAGY')),
            actions: [
              ConditionalBuilder(
                condition: cupit.currentIndex == 3,
                builder: (context) => TextButton(
                  onPressed: () {
                    CacheHelper.removeData(key: 'token').then((value) {
                      if (value) {
                        NavigateAndFinish(context, Login_Screen());
                      }
                    });
                    cupit.currentIndex = 0;
                  },
                  child: Text(
                    'Sign out',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                fallback: (context) => IconButton(
                  onPressed: () {
                    NavigateTo(context, SearchScreen());
                  },
                  icon: Icon(
                    Icons.search_rounded,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cupit.Items,
            currentIndex: cupit.currentIndex,
            onTap: (index) {
              cupit.changeBottomNavBar(index);
            },
          ),
          body: cupit.Screens[cupit.currentIndex],
        );
      },
    );
  }
}
