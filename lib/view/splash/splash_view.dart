import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stay_x/res/asset_helpers/image_assets.dart';
import 'package:stay_x/res/colors/app_color.dart';
import 'package:stay_x/view_models/services/splash_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  //Initializing the splash services
  SplashServices splashServices = SplashServices();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    splashServices.isLogin();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller);
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(
    //     const Duration(seconds: 5),
    //     () => Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(builder: (context) => const DashboardScreen()),
    //         ModalRoute.withName("/Home")));

    var mLogo = SvgPicture.asset(ImageAssets.logoIconName,
        width: 180, semanticsLabel: 'Logo on Splash');
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColor.appDark, AppColor.appLight]),
        ),
        child: Stack(
          children: [
            SvgPicture.asset(
              ImageAssets.bgGrid,
              fit: BoxFit.fill,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: FadeTransition(opacity: _animation, child: mLogo),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 80),
                        Container(
                            margin: const EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
                            child: const LinearProgressIndicator(
                              color: AppColor.appDark,
                              backgroundColor: AppColor.appLight,
                            )),
                        const Expanded(
                            flex: 1,
                            child: Padding(
                                padding:
                                    EdgeInsets.only(right: 10.0, bottom: 4.0),
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "Version : 1 (1.0.1)",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.white),
                                    ))))
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
