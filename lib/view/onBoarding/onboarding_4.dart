// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stay_x/res/asset_helpers/image_assets.dart';
import 'package:stay_x/res/colors/app_color.dart';
import 'package:stay_x/res/components/custom_buttons.dart';

class OnboardingFourView extends StatefulWidget {
  const OnboardingFourView({super.key});

  @override
  State<OnboardingFourView> createState() => _OnboardingFourViewState();
}

class _OnboardingFourViewState extends State<OnboardingFourView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    final key = GlobalKey();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SvgPicture.asset(ImageAssets.bgGrid,
              fit: BoxFit.fill, color: Colors.grey.shade400),
          Positioned(bottom: 0, child: SvgPicture.asset(ImageAssets.bgWave)),
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
                Center(child: Container()),
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
                loading: false,
                title: 'Tell me more',
                onPress: () {
                  // Navigator.push(
                    // context,
                    // Utils.slideTransitionRoute(
                      // page: const OnboardingTwoView(),
                    // ),
                  // );
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 25,
            child: Center(
              child: InkWell(
                  onTap: () {},
                  child: Text(
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    "Skip onboarding",
                    key: key,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
