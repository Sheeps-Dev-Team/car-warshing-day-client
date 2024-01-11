import 'dart:convert';

import 'package:car_washing_day/config/global_assets.dart';
import 'package:car_washing_day/screens/home/controllers/home_controller.dart';
import 'package:car_washing_day/util/global_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../config/constants.dart';
import '../../config/weather_assets.dart';
import '../../data/global_data.dart';
import '../../data/models/weather.dart';
import '../../util/components/bubble/bubble.dart';
import '../../util/components/bubble/bubble_lump.dart';
import '../../util/components/car_animation.dart';
import '../../util/components/custom_button.dart';
import '../../util/components/rain/rain.dart';
import '../main/address_input_page.dart';
import 'controllers/calendar_page_controller.dart';

import 'package:http/http.dart' as http;

class CalendarPage extends StatelessWidget {
  CalendarPage({super.key});

  final CalendarPageController controller = Get.put(CalendarPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CalendarPageController>(
        initState: (state) => controller.init(),
        builder: (_) {
          return Column(
            children: [
              Gap($style.insets.$24),

              /// header
              header(),
              Gap($style.insets.$24),

              /// calendar
              yearAndMonth(), // 년도. 달
              Gap($style.insets.$16),
              SizedBox(
                height: 97 * sizeUnit,
                child: GlobalData.weatherList.isNotEmpty
                    ? ScrollablePositionedList.builder(
                        itemScrollController: controller.itemScrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: GlobalData.weatherList.length,
                        itemBuilder: (context, index) {
                          final Weather weather = GlobalData.weatherList[index];

                          return weatherItem(
                            index: index,
                            weather: weather,
                            onTap: () => controller.onSelectionChanged(weather.dateTime),
                          );
                        },
                      )
                    : exceptionText(),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: $style.insets.$16),
                child: Divider(color: $style.colors.lightGrey, height: 1 * sizeUnit),
              ),

              /// estimatedDate
              if (GlobalData.weatherList.isNotEmpty) ...[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: $style.insets.$16),
                    child: ListView(
                      children: [
                        Gap($style.insets.$24),
                        if (GlobalData.loginUser?.washingCarDay != null) ...[
                          estimatedDateItem(
                            label: '세차일',
                            periodStart: GlobalData.loginUser!.washingCarDay!.startedAt,
                            continuousDay:
                                GlobalFunction.getContinuousDays(startIdx: GlobalData.loginUser!.washingCarDay!.startedAt.difference(GlobalData.weatherList.first.dateTime).inDays),
                            color: $style.colors.red,
                            trailingIconPath: GlobalAssets.svgMinusInCircle,
                            isWashingDay: true,
                          ),
                          Gap($style.insets.$24),
                          Divider(color: $style.colors.lightGrey, height: 1 * sizeUnit),
                          Gap($style.insets.$24),
                        ],
                        estimatedDateItem(
                          label: '예상 지속일',
                          periodStart: controller.selectedDate,
                          continuousDay: controller.continuousDays,
                          color: $style.colors.primary,
                        ),
                        Gap($style.insets.$24),
                        estimatedDateItem(
                          label: '추천일',
                          periodStart: controller.recommendDate,
                          continuousDay: controller.recommendContinuousDays,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  // 에상 지속일 아이템
  Row estimatedDateItem({
    required String label,
    required DateTime periodStart,
    required int continuousDay,
    Color? color,
    String? trailingIconPath,
    bool isWashingDay = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 34 * sizeUnit),
              child: Text(
                DateFormat('MM.dd').format(periodStart),
                style: $style.text.subTitle12.copyWith(fontFamily: dmSans),
              ),
            ),
            if (isWashingDay) ...[
              Gap($style.insets.$4),
              SvgPicture.asset(GlobalAssets.svgPin, width: 20 * sizeUnit),
            ],
          ],
        ),
        Gap($style.insets.$16),
        Expanded(
          child: Container(
            height: 48 * sizeUnit,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular($style.corners.$4),
              boxShadow: $style.boxShadows.bs2,
            ),
            child: Row(
              children: [
                Container(
                  width: 4 * sizeUnit,
                  height: 48 * sizeUnit,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular($style.corners.$4),
                      bottomLeft: Radius.circular($style.corners.$4),
                    ),
                  ),
                ),
                Gap($style.insets.$12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label, style: $style.text.subTitle14.copyWith(height: 1.15)),
                      Gap($style.insets.$2),
                      RichText(
                        text: TextSpan(
                          style: $style.text.body12.copyWith(
                            fontFamily: dmSans,
                            color: $style.colors.darkGrey,
                            height: 1.15,
                          ),
                          children: [
                            TextSpan(text: DateFormat('MM.dd').format(periodStart)),
                            const TextSpan(text: ' - '),
                            TextSpan(text: DateFormat('MM.dd').format(periodStart.add(Duration(days: continuousDay == 0 ? 0 : continuousDay - 1)))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '$continuousDay일',
                  style: $style.text.title18.copyWith(color: color ?? $style.colors.darkGrey),
                ),
                Gap($style.insets.$12),
                InkWell(
                  onTap: () => controller.openDetailDialog(
                    detailDialogWidget(
                      periodStart: periodStart,
                      continuousDay: continuousDay,
                      color: label == '추천일' ? $style.colors.primary : color,
                      isWashingDay: isWashingDay,
                    ),
                  ),
                  child: SvgPicture.asset(
                    trailingIconPath ?? GlobalAssets.svgPlusInCircle,
                    width: 20 * sizeUnit,
                  ),
                ),
                Gap($style.insets.$8),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 날씨 아이템
  Padding weatherItem({required int index, required Weather weather, required GestureTapCallback onTap}) {
    final bool isSelected = weather.dateTime == controller.selectedDate;
    final bool isWashingDay = weather.dateTime.year == GlobalData.loginUser?.washingCarDay?.startedAt.year &&
        weather.dateTime.month == GlobalData.loginUser?.washingCarDay?.startedAt.month &&
        weather.dateTime.day == GlobalData.loginUser?.washingCarDay?.startedAt.day;

    return Padding(
      padding: EdgeInsets.only(
        left: index == 0 ? $style.insets.$20 : 0,
        right: $style.insets.$16,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          children: [
            Text(
              '${DateFormat('EEE').format(weather.dateTime).toUpperCase()}\n${weather.dateTime.day}',
              style: $style.text.headline12.copyWith(
                fontFamily: dmSans,
                color: weather.getWeekdayColor,
                height: 1.15,
              ),
              textAlign: TextAlign.center,
            ),
            Gap($style.insets.$8),
            Container(
              padding: EdgeInsets.fromLTRB(0, $style.insets.$4, 0, $style.insets.$6),
              width: 32 * sizeUnit,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular($style.corners.$4),
                boxShadow: $style.boxShadows.bs1,
                color: isWashingDay
                    ? $style.colors.red
                    : isSelected
                        ? $style.colors.primary
                        : Colors.white,
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    weather.getWeatherIcon,
                    width: 24 * sizeUnit,
                    colorFilter: (isWashingDay || isSelected) && weather.getWeatherIcon == WeatherAssets.snowy
                        ? const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          )
                        : null,
                  ),
                  Gap($style.insets.$2),
                  Text(
                    '${weather.pop}%',
                    style: $style.text.subTitle10.copyWith(
                      fontFamily: dmSans,
                      color: isWashingDay || isSelected ? Colors.white : $style.colors.primary,
                      fontWeight: isWashingDay || isSelected ? FontWeight.bold : FontWeight.w500,
                      height: 1.15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 년도. 달
  Row yearAndMonth() {
    return Row(
      children: [
        Gap($style.insets.$12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: $style.insets.$8),
          child: Text(
            DateFormat('yyyy. MM.').format(controller.selectedDate),
            style: $style.text.headline16.copyWith(fontFamily: dmSans),
          ),
        ),
      ],
    );
  }

  Future<void> sendNotificationToDevice({required String deviceToken, required String title, required String content, required Map<String, dynamic> data}) async {
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=BOLtfwUZVTZpNMV3iSh0EDPQG0Af_ZD_3XGQFMuPxeM',
    };

    final body = {
      'notification': {'title': title, 'body': content, 'data': data},
      'to': deviceToken,
    };

    final response = await http.post(url, headers: headers, body: json.encode(body));

    if (response.statusCode == 200) {
      // Notification sent successfully
      print("성공적으로 전송되었습니다.");
      print("$title $content");
    } else {
      print(response.body);
      // Failed to send notification
      print("전송에 실패하였습니다.");
    }
  }

  Padding header() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $style.insets.$16),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: $style.text.headline20.copyWith(color: $style.colors.primary, height: 1.15),
                children: [
                  const TextSpan(text: '예상 지속일'),
                  TextSpan(text: ' 은\n약 ', style: $style.text.title16),
                  TextSpan(
                    text: '${controller.continuousDays} ',
                    style: TextStyle(fontSize: 24 * sizeUnit),
                  ),
                  TextSpan(text: '일 입니다.', style: $style.text.title16),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: $style.insets.$4),
            child: SizedBox(
              width: 120 * sizeUnit,
              height: 68 * sizeUnit,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Bubble(),
                    Positioned(
                      bottom: 8 * sizeUnit,
                      child: BubbleLump(width: 110 * sizeUnit),
                    ),
                    const CarAnimation(),
                    if (GlobalData.currentWeather != null) ...[
                      Rain(rainingType: GlobalData.currentWeather!.rainingType),
                    ],
                  ],
                ),
              ),
            ),
          ),
          // Column(
          //   children: [
          //     CustomButton.small(
          //       text: '로그인 하기',
          //       onTap: () {
          //         UserRepository.login('test@gmail.com', '구글');
          //       },
          //     ),
          //     CustomButton.small(
          //         text: '토큰 보내기',
          //         onTap: () {
          //           FirebaseMessaging.instance.getToken().then((token) {
          //             if (token != null) {
          //               print(token);
          //               UserRepository.updateFcmToken(token);
          //             }
          //           });
          //           // sendNotificationToDevice(deviceToken: 'dyTkhibS3k8hji9IIXgj0N:APA91bEEPJEnfGJwzPWYgFy50Wfc_eYekwIlWT8xJM7sh-AqvOl1MpJbdvoJiePNPpSfDqQw46FfTWhhg7ubOYZ-S23lHrV-zf1GLlHOWWo6FpztEyGaL0AuToIupdkvqGy9FHVIue0q',
          //           //   title: 'test',
          //           //   content: 'contents',
          //           //   data: {'test_parameter1': 1, 'test_parameter2': '테스트1'},
          //           // );
          //         })
          //   ],
          // ),
        ],
      ),
    );
  }

  // 예외 텍스트
  Widget exceptionText() {
    final HomeController homeController = Get.find<HomeController>();
    final bool isEmptyAddress = homeController.address.isEmpty;

    return GestureDetector(
      onTap: () => isEmptyAddress ? Get.to(() => AddressInputPage()) : GlobalFunction.setWeatherList(homeController.address.value),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isEmptyAddress ? '위치를 설정해 주세요' : '날씨 정보를 받아오지 못했습니다.\n잠시후 다시 시도해 주세요.',
            style: $style.text.subTitle12.copyWith(
              color: $style.colors.primary,
              height: isEmptyAddress ? 1 : 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          if (isEmptyAddress) ...[
            SizedBox(
              width: 100 * sizeUnit,
              child: Divider(
                height: 1 * sizeUnit,
                thickness: 1 * sizeUnit,
                color: $style.colors.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // 디테일 다이얼로그 위젯
  Widget detailDialogWidget({
    required DateTime periodStart,
    required int continuousDay,
    Color? color,
    bool isWashingDay = false,
  }) {
    final DateTime periodEnd = periodStart.add(Duration(days: continuousDay));
    final bool isShowLongTerm = periodEnd.difference(GlobalData.weatherList.last.dateTime).inDays >= 0;

    return GetBuilder<CalendarPageController>(
        id: 'detailDialog',
        initState: (state) {
          if (isShowLongTerm) controller.setLongTerm(); // 장기 예보 세팅
        },
        builder: (_) {
          return Material(
            type: MaterialType.transparency,
            child: Center(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: $style.insets.$24),
                    padding: EdgeInsets.symmetric(horizontal: $style.insets.$16, vertical: $style.insets.$24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular($style.corners.$8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('상세 정보', style: $style.text.headline18),
                        Gap($style.insets.$24),
                        detailEstimatedDateItem(
                          periodStart: periodStart,
                          continuousDay: continuousDay,
                          color: color,
                        ),
                        // 장기까지 지속일이 이어진 경우
                        if (isShowLongTerm && controller.longTermForecast != null) ...[
                          Gap($style.insets.$16),
                          // 장기 +2
                          detailEstimatedDateItem(
                            periodStart: controller.longTermForecast!.baseDate.add(const Duration(days: 1)),
                            continuousDay: 2,
                            longTermProbability: controller.longTermForecast!.getProbability(2),
                          ),
                          Gap($style.insets.$16),
                          // 장기 +4
                          detailEstimatedDateItem(
                            periodStart: controller.longTermForecast!.baseDate.add(const Duration(days: 1)),
                            continuousDay: 4,
                            longTermProbability: controller.longTermForecast!.getProbability(4),
                          ),
                        ],
                        Gap($style.insets.$24),
                        CustomButton(
                          text: isWashingDay ? '등록 해제' : '세차일 등록',
                          color: color,
                          onTap: () => isWashingDay ? controller.deleteWashingCarDay() : controller.setWashingCarDay(periodStart: periodStart, periodEnd: periodEnd),
                        ),
                        Gap($style.insets.$12),
                        Text(
                          isWashingDay ? '예상 지속 기간 변경 푸시 알림이 해제돼요!' : '예상 지속 기간 변경 시 자동 푸시 알림이 가요!',
                          style: $style.text.subTitle12.copyWith(color: $style.colors.darkGrey),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: $style.insets.$16,
                    right: $style.insets.$40,
                    child: InkWell(
                      onTap: Get.back,
                      child: SvgPicture.asset(GlobalAssets.svgCancel, width: 24 * sizeUnit),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  // 디테일 에상 지속일 아이템
  Widget detailEstimatedDateItem({
    required DateTime periodStart,
    required int continuousDay,
    Color? color,
    double? longTermProbability,
  }) {
    return Container(
      height: 48 * sizeUnit,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular($style.corners.$4),
        boxShadow: $style.boxShadows.bs2,
      ),
      child: Row(
        children: [
          Container(
            width: 4 * sizeUnit,
            height: 48 * sizeUnit,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular($style.corners.$4),
                bottomLeft: Radius.circular($style.corners.$4),
              ),
            ),
          ),
          Gap($style.insets.$12),
          Expanded(
            child: longTermProbability == null
                ? Text(
                    DateFormat('MM.dd').format(periodStart),
                    style: $style.text.subTitle12.copyWith(fontFamily: dmSans, height: 1.15),
                  )
                : Text(
                    '${(longTermProbability * 100).round()}%',
                    style: $style.text.subTitle14.copyWith(height: 1.15),
                  ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('예상 지속 기간', style: $style.text.subTitle12.copyWith(height: 1.15)),
                Gap($style.insets.$2),
                RichText(
                  text: TextSpan(
                    style: $style.text.body12.copyWith(
                      fontFamily: dmSans,
                      color: $style.colors.darkGrey,
                      height: 1.15,
                    ),
                    children: [
                      TextSpan(text: DateFormat('MM.dd').format(periodStart)),
                      const TextSpan(text: ' - '),
                      TextSpan(text: DateFormat('MM.dd').format(periodStart.add(Duration(days: continuousDay == 0 ? 0 : continuousDay - 1)))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${longTermProbability != null ? '+' : ''}$continuousDay일',
                style: $style.text.title18.copyWith(color: color ?? $style.colors.darkGrey),
              ),
            ),
          ),
          Gap($style.insets.$20),
        ],
      ),
    );
  }
}
