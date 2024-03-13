import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_x/res/components/custom_buttons.dart';
import 'package:stay_x/res/routes/routes_name.dart';
import 'package:stay_x/view_models/controller/login/login_view_model.dart';

import '../../utils/utils.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
    final width = MediaQuery.of(context).size.width;
    final authViewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: const InputDecoration(
                hintText: "Enter your email",
                prefixIcon: Icon(Icons.email),
              ),
              onFieldSubmitted: (value) {
                // FocusScope.of(context).requestFocus(passwordFocusNode);
                Utils.fieldFocusChange(
                    context, emailFocusNode, passwordFocusNode);
              },
            ),
            const SizedBox(
              height: 50,
            ),
            ValueListenableBuilder(
              valueListenable: obSecurePassword,
              builder: (context, value, child) {
                return TextFormField(
                  controller: passwordController,
                  obscureText: obSecurePassword.value,
                  obscuringCharacter: "*",
                  focusNode: passwordFocusNode,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: InkWell(
                        onTap: () {
                          obSecurePassword.value = !obSecurePassword.value;
                        },
                        child: obSecurePassword.value
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility_outlined)),
                  ),
                );
              },
            ),
            SizedBox(
              height: height * 0.1,
            ),
            RoundButton(
              loading: authViewModel.loading.value,
              title: 'SignUp',
              onPress: () {
                if (emailController.text.isEmpty) {
                  Utils.flushBarErrorMessage('Email can\'t be empty', context);
                } else if (passwordController.text.isEmpty) {
                  Utils.flushBarErrorMessage(
                      'Password can\'t be empty', context);
                } else if (passwordController.text.length < 6) {
                  Utils.flushBarErrorMessage(
                      'Password should be 6 digits', context);
                } else {
                  //Compiling data
                  Map data = {
                    "email": emailController.text.toString(),
                    "password": passwordController.text.toString()
                  };
                  //Calling Api
                  authViewModel.loginApi();
                  // authViewModel.loginApi(data, context);
                  debugPrint("Api hit");
                }
              },
            ),
            SizedBox(
              height: height * 0.010,
            ),
            InkWell(
                onTap: () => Navigator.pushNamed(context, RouteName.login),
                child: const Text("Already have a account. LogIn")),
          ],
        ),
      ),
    );
  }
}
