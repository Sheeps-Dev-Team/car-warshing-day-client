import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'config/constants.dart';
import 'config/style.dart';
import 'firebase_options.dart';
import 'screens/main/splash_screen.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("백그라운드 메시지 처리.. ${message.notification!.body!}");
}

@pragma('vm:entry-point')
void backgroundHandler(NotificationResponse details) {
  // 액션 추가... 파라미터는 details.payload 방식으로 전달
}

void initializeNotification() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
      'high_importance_channel', 'high_importance_notification',
      importance: Importance.max)
  );

  await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings()
      )
      ,onDidReceiveNotificationResponse: (details) {
      },
      onDidReceiveBackgroundNotificationResponse: backgroundHandler,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  if(Platform.isAndroid) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'high_importance_channel',
                'high_importance_notification',
                importance: Importance.max,
              ),
              iOS: DarwinNotificationDetails(),
            ),
            payload: message.data['test_paremeter1']);
        print("수신자 측 메시지 수신");
      }
    });
  }

  RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
  if (message != null) {
    // 액션 부분 -> 파라미터는 message.data['test_parameter1'] 이런 방식으로...


  }
}

Future<void> setupInteractedMessage() async {
  // Get any messages which caused the application to open from
  // a terminated state.
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();

  // If the message also contains a data property with a "type" of "chat",
  // navigate to a chat screen
  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }

  // Also handle any interaction when the app is in the background via a
  // Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
}

void _handleMessage(RemoteMessage message) {
  debugPrint(message.data.toString());
}


void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize(); // admob
  KakaoSdk.init(nativeAppKey: kakaoNativeAppKey); // kakao init

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeNotification();
  setupInteractedMessage();

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
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static final FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

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
      navigatorObservers: [observer], // 애널리틱스 옵져버 세팅
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
