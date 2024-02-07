import 'package:car_washing_day/config/storage.dart';
import 'package:car_washing_day/screens/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../config/constants.dart';
import '../../config/global_assets.dart';
import '../../data/global_data.dart';
import '../../util/global_function.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String route = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  initState() {
    super.initState();

    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationController.forward();

    Future.delayed(const Duration(milliseconds: 500), () async {
      final String? email = await Storage.getEmail();
      final String? loginType = await Storage.getLoginType();

      String? address = await Storage.getAddress();

      // 위치 데이터 있는 경우
      if(address != null) {
        await GlobalFunction.setWeatherList(address);
      }

      if (email != null && loginType != null) {
        GlobalFunction.globalLogin(
          email: email,
          loginType: loginType,
        );
      } else {
        Get.off(() => MainPage());
      }
    });

    // Future.delayed(
    //   const Duration(milliseconds: 2000),
    //   () => Get.off(() => MainPage()),
    // );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedLogo(animation: animation),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);

  const AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    const double logoWidth = 175;

    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: SvgPicture.asset(
        GlobalAssets.svgLogo,
        width: sizeUnit == 0 ? logoWidth : logoWidth * sizeUnit,
      ),
    );
  }
}
