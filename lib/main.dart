import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'config/constants.dart';
import 'config/style.dart';
import 'screens/main/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static AppStyle get style => _style;
  static AppStyle _style = AppStyle();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    setSizeUnit(); // 사이즈 유닛 세팅
  }

  // 사이즈 유닛 세팅
  void setSizeUnit() async {
    if(kIsWeb) {
      sizeUnit = 1;
      return;
    }

    sizeUnit = WidgetsBinding
        .instance.platformDispatcher.views.first.physicalSize.width /
        WidgetsBinding
            .instance.platformDispatcher.views.first.devicePixelRatio /
        360;

    if (sizeUnit == 0) {
      if (kDebugMode) debugPrint('reset sizeUnit!');

      await Future.delayed(const Duration(milliseconds: 500), () {
        sizeUnit = WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.width /
            WidgetsBinding
                .instance.platformDispatcher.views.first.devicePixelRatio /
            360;
        if (sizeUnit == 0) sizeUnit = 1;
      });

      if (kDebugMode) debugPrint("size unit is $sizeUnit");
      MyApp._style = AppStyle(sizeUnit: sizeUnit); // 스타일 세팅
    } else {
      if (kDebugMode) debugPrint("size unit is $sizeUnit");
      MyApp._style = AppStyle(sizeUnit: sizeUnit); // 스타일 세팅
    }

    // 큰 사이즈 기기 대응
    if(sizeUnit >= 1.8) {
      sizeUnit = 1.2;
      MyApp._style = AppStyle(sizeUnit: sizeUnit); // 스타일 세팅
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: '세차언제',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Pretendard',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: $style.colors.primary),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
      initialRoute: SplashScreen.route,
      getPages: [
        GetPage(name: SplashScreen.route, page: () => const SplashScreen()),
      ],
    );
  }
}
