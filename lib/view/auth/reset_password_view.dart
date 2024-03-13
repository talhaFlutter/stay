// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:stay_x/res/asset_helpers/app_icons.dart';
import 'package:stay_x/res/asset_helpers/image_assets.dart';
import 'package:stay_x/res/colors/app_color.dart';
import 'package:stay_x/res/components/custom_buttons.dart';
import 'package:stay_x/res/routes/routes_name.dart';
import '../../utils/utils.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  ValueNotifier obSecurePassword = ValueNotifier(true);

  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
    obSecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SvgPicture.asset(ImageAssets.bgGrid,
              fit: BoxFit.fill, color: Colors.grey.shade400),
          Positioned(bottom: 0, child: SvgPicture.asset(ImageAssets.authBgWave)),
          Padding(
            padding: const EdgeInsets.only(right: 30.0, left: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(ImageAssets.logoIconName,
                    width: 180,
                    color: AppColor.appBaseBlueColor,
                    semanticsLabel: 'Logo on Login'),
                const SizedBox(
                  height: 100,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context, RouteName.resetPassword);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.arrowLeft,
                        color: AppColor.appText,
                      ),
                      const Text(
                        textAlign: TextAlign.left,
                        " back to login?",
                        style: TextStyle(
                            color: AppColor.appText,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  textAlign: TextAlign.left,
                  "Reset password",
                  style: TextStyle(
                      fontSize: 24,
                      color: AppColor.appText,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: AppColor.appTextFiledBorderColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.appHintColor),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: emailFocusNode,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: AppColor.appHintColor),
                      border: InputBorder.none,
                      hintText: "E-Mail",
                      prefixIcon: Icon(Icons.email,
                          color: AppColor.appBasePurpleColor),
                    ),
                    onFieldSubmitted: (value) {
                      // FocusScope.of(context).requestFocus(passwordFocusNode);
                      // Utils.fieldFocusChange(
                      // context, emailFocusNode, passwordFocusNode);
                    },
                  ),
                ),

                const SizedBox(
                  height: 200,
                ),
                SizedBox(
                  height: height * 0.1,
                ),

                // InkWell(
                //     onTap: () {
                //       Navigator.pushNamed(context, RoutesName.register);
                //     },
                //     child: const Text("Don't have an account? Sign Up",)),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Center(
              child: RoundButton(
                loading: false,
                title: 'Request new password',
                onPress: () {
                  if (emailController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        'Email can\'t be empty', context);
                  } else {
                    Navigator.pushNamed(
                        context, RouteName.resetPasswordRequested);
                    //Compiling data
                    // Map data = {
                    //   "email": emailController.text.toString(),
                    //   "password": passwordController.text.toString()
                    // };
                    // Map data = {
                    //   "email": "eve.holt@reqres.in",
                    //   "password": "cityslicka"
                    // };
                    // //Calling Api
                    // authViewModel.loginApi(data, context);
                    // debugPrint("Api hit");
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
