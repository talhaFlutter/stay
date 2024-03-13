// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:stay_x/res/asset_helpers/image_assets.dart';
import 'package:stay_x/res/colors/app_color.dart';
import 'package:stay_x/res/components/custom_buttons.dart';
import 'package:stay_x/res/components/custom_popup.dart';
import 'package:stay_x/res/routes/routes_name.dart';
import '../../utils/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ValueNotifier obSecurePassword = ValueNotifier(true);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                      Utils.fieldFocusChange(
                          context, emailFocusNode, passwordFocusNode);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder(
                  valueListenable: obSecurePassword,
                  builder: (context, value, child) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: AppColor.appTextFiledBorderColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.appHintColor),
                        controller: passwordController,
                        obscureText: obSecurePassword.value,
                        obscuringCharacter: "*",
                        focusNode: passwordFocusNode,
                        decoration: InputDecoration(
                          hintStyle:
                              const TextStyle(color: AppColor.appHintColor),
                          border: InputBorder.none,
                          hintText: "Password",
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColor.appBasePurpleColor,
                          ),
                          suffixIcon: InkWell(
                              onTap: () {
                                obSecurePassword.value =
                                    !obSecurePassword.value;
                              },
                              child: obSecurePassword.value
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: AppColor.lightGrayColor,
                                    )
                                  : const Icon(Icons.visibility_outlined,
                                      color: AppColor.lightGrayColor)),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomPopup(
                              title: 'How can I login?',
                              description:
                                  "You should have received your login credentials via email after being invited by your admin. If you're having trouble logging in, please contact your HR department or administrator.",
                              logo: const Icon(Icons.info),
                              showTitle: true,
                              showDescription: true,
                              showLogo: false,
                              buttons: [
                                ButtonConfig(
                                  text: "Got it ➜",
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  borderColor: Colors.blue,
                                  onPressed: () {
                                    // Do something when Button 1 is pressed
                                  },
                                ),
                                ButtonConfig(
                                  text: 'Got it ➜',
                                  color: Colors.green,
                                  textColor: Colors.white,
                                  borderColor: Colors.green,
                                  onPressed: () {
                                    // Do something when Button 2 is pressed
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        textAlign: TextAlign.right,
                        "How can I login?",
                        style: TextStyle(
                            color: AppColor.appText,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.resetPassword);
                      },
                      child: const Text(
                        textAlign: TextAlign.right,
                        "Forgot Password?",
                        style: TextStyle(
                            color: AppColor.appText,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 200,
                ),
                SizedBox(
                  height: height * 0.1,
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Center(
              child: RoundButton(
                title: 'Login',
                onPress: () {
                  Get.toNamed(RouteName.onBoarding1);
                

                  // if (emailController.text.isEmpty) {
                  //   Utils.flushBarErrorMessage(
                  //       'Email can\'t be empty', context);
                  // } else if (passwordController.text.isEmpty) {
                  //   Utils.flushBarErrorMessage(
                  //       'Password can\'t be empty', context);
                  // } else if (passwordController.text.length < 6) {
                  //   Utils.flushBarErrorMessage(
                  //       'Password should be 6 digits', context);
                  // } else {
                  //   //Compiling data
                  //   // Map data = {
                  //   //   "email": emailController.text.toString(),
                  //   //   "password": passwordController.text.toString()
                  //   // };
                  //   Map data = {
                  //     "email": "eve.holt@reqres.in",
                  //     "password": "cityslicka"
                  //   };
                  //   //Calling Api
                  //   authViewModel.loginApi(data, context);
                  //   debugPrint("Api hit");
                  // }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
