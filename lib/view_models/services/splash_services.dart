import 'dart:async';

import 'package:get/get.dart';
import 'package:stay_x/res/routes/routes_name.dart';
import 'package:stay_x/view_models/controller/user_preference/user_prefrence_view_model.dart';

class SplashServices {
  UserPreference userPreference = UserPreference();

  void isLogin() {
    userPreference.getUser().then((value) {
      print(value.token);
      print(value.isLogin);

      if (value.isLogin == false || value.isLogin.toString() == 'null') {
        Timer(
            const Duration(seconds: 3), () => Get.toNamed(RouteName.login));
      } else {
        Timer(
            const Duration(seconds: 3), () => Get.toNamed(RouteName.home));
      }
    });
  }
}
