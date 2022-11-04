import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/on_boarding.dart';
import 'package:shop_app/sheared/app_theme/dark_theme.dart';
import 'package:shop_app/sheared/app_theme/light_theme.dart';
import 'package:shop_app/sheared/constant/constant.dart';
import 'package:shop_app/sheared/cubit/cubit.dart';
import 'package:shop_app/sheared/cubit/states.dart';
import 'package:shop_app/sheared/network/remote/dio_hekper.dart';
import 'package:shop_app/test.dart';

import 'sheared/network/local/cashe_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  BlocOverrides.runZoned(() {}, blocObserver: MyBlocObserver());

  Widget? startWidget;
  bool? darkMode = CacheHelper.getData(key: 'DarkMode');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      {
        startWidget = Shop_layout();
      }
    } else {
      startWidget = Login_Screen();
    }
  } else {
    startWidget = const OnBoardingScreen();
  }

  runApp(ShopApp(
    starting: startWidget,
    isdark: darkMode,
  ));
}

class ShopApp extends StatelessWidget {
  final Widget? starting;
  final bool? isdark;
  ShopApp({required this.starting, required this.isdark});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..homeData()
        ..categoryModel()
        ..getUserDataModel()
        ..GetDataFavModel()
        ..ChangeMode(isDark: isdark),
      child: BlocConsumer<AppCubit, States>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: AppCubit.get(context).DarkMade
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: LightTheme,
            darkTheme: DarkTheme,
            home: starting,
          );
        },
      ),
    );
  }
}
