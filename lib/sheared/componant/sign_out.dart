import 'package:flutter/material.dart';

import '../../modules/login/login.dart';
import '../network/local/cashe_helper.dart';
import 'navigate.dart';

void SignOut(context) {
  TextButton(
    onPressed: () {
      CacheHelper.removeData(key: 'token').then((value) {
        if (value) {
          NavigateAndFinish(context, Login_Screen());
        }
      });
    },
    child: Text('Sign out'),
  );
}
