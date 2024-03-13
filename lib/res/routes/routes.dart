import 'package:get/get.dart';
import 'package:stay_x/res/components/avatar_generator.dart';
import 'package:stay_x/res/routes/routes_name.dart';
import 'package:stay_x/view/auth/login_view.dart';
import 'package:stay_x/view/auth/reset_password_requested_view.dart';
import 'package:stay_x/view/auth/reset_password_view.dart';
import 'package:stay_x/view/home/home_view.dart';
import 'package:stay_x/view/onBoarding/onboarding_1.dart';
import 'package:stay_x/view/onBoarding/onboarding_2.dart';
import 'package:stay_x/view/onBoarding/onboarding_3.dart';
import 'package:stay_x/view/onBoarding/onboarding_4.dart';
import 'package:stay_x/view/splash/splash_view.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.splash,
          page: () => const SplashView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.login,
          page: () => AvatarCreationScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.home,
          page: () => const HomeView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.resetPassword,
          page: () => const ResetPasswordView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.resetPasswordRequested,
          page: () => const ResetPasswordRequestedView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.onBoarding1,
          page: () => const OnboardingOneView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.onBoarding2,
          page: () => const OnboardingTwoView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.onBoarding3,
          page: () => const OnboardingThreeView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.onBoarding4,
          page: () => const OnboardingFourView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
      ];
}
