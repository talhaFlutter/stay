import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stay_x/res/components/custom_buttons.dart';
import 'package:stay_x/view_models/controller/login/login_view_model.dart';

class LoginButtonWidget extends StatelessWidget {
  final formKey;
  LoginButtonWidget({Key? key, required this.formKey}) : super(key: key);

  final loginVM = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() => RoundButton(
        title: 'login'.tr,
        loading: loginVM.loading.value,
        onPress: () {
          if (formKey.currentState!.validate()) {
            loginVM.loginApi();
          }
        }));
  }
}
