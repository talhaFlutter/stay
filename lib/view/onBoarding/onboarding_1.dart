// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:stay_x/res/asset_helpers/image_assets.dart';
import 'package:stay_x/res/colors/app_color.dart';
import 'package:stay_x/res/components/custom_buttons.dart';
import 'package:stay_x/res/components/info_bubble.dart';
import 'package:stay_x/res/routes/routes_name.dart';
import 'package:stay_x/view/onBoarding/onboarding_2.dart';
import '../../utils/utils.dart';

class OnboardingOneView extends StatefulWidget {
  const OnboardingOneView({super.key});

  @override
  State<OnboardingOneView> createState() => _OnboardingOneViewState();
}

class _OnboardingOneViewState extends State<OnboardingOneView>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation1 = Tween<double>(begin: 0, end: 1).animate(_controller1);
    _animation2 = Tween<double>(begin: 0, end: 1).animate(_controller2);

    _controller1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller2.forward();
      }
    });

    _controller1.forward();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
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
                GestureDetector(
                  onTap: () {
                    showInfoBubble(
                      'Tool tip title',
                      'Tool tip description it is',
                      key,
                      Colors.white,
                    );
                  },
                  child: const Text(
                    'Test Tooltip',

                    ///Added GlobalKey to our anchor widget.
                    ///On clicking this text it will show the
                    ///Info bubble
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ScaleTransition(
                        scale: _animation1,
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 20),
                      ScaleTransition(
                        scale: _animation2,
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
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
                    title: 'Tell me more',
                    onPress: () {
                      Get.toNamed(RouteName.onBoarding2);
                    })),
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
