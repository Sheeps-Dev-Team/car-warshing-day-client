import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../config/constants.dart';
import '../../config/global_assets.dart';
import 'main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  initState() {
    super.initState();

    animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationController.forward();

    //   Future.delayed(const Duration(milliseconds: 2000), () async {
    //     const FlutterSecureStorage storage = FlutterSecureStorage();
    //     final String? email = await storage.read(key: loginEmail);
    //
    //     if(email != null) {
    //       GlobalFunction.globalLogin(
    //         email: email,
    //         nullCallback: () {
    //           storage.delete(key: loginEmail); // 로컬 저장소 loginEmail 데이터 삭제
    //           Get.off(() => LoginPage());
    //         },
    //       );
    //     } else {
    //       Get.off(() => LoginPage());
    //     }
    //   });

    Future.delayed(
      const Duration(milliseconds: 2000),
      () => Get.off(() => MainPage()),
    );
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

  const AnimatedLogo({Key? key, required Animation<double> animation}) : super(key: key, listenable: animation);

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
