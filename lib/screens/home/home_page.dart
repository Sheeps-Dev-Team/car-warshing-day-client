import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/data/global_data.dart';
import 'package:car_washing_day/screens/home/controllers/home_controller.dart';
import 'package:car_washing_day/util/components/bubble/bubble.dart';
import 'package:car_washing_day/util/components/car_animation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../util/components/bubble/bubble_lump.dart';
import '../../util/components/rain/rain.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    controller.setAddress(); // 위치 세팅

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Text('오늘 세차하면?', style: $style.text.subTitle16.copyWith(height: 1.15)),
            Gap($style.insets.$8),
            Text('20일 지속', style: $style.text.headline40.copyWith(height: 1.15)),
            const Spacer(),
            SizedBox(
              width: 260 * sizeUnit,
              height: 160 * sizeUnit,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Bubble(),
                    Positioned(
                      bottom: 20 * sizeUnit,
                      child: BubbleLump(width: 260 * sizeUnit),
                    ),
                    const CarAnimation(),
                    if (GlobalData.todayWeather != null) ...[
                      Rain(rainingType: GlobalData.todayWeather!.rainingType),
                    ],
                  ],
                ),
              ),
            ),
            const Spacer(),
            Obx(() => Text(
                  controller.address.value.replaceFirst(division, ' '),
                  style: $style.text.subTitle12,
                )),
            Gap($style.insets.$8),
            SizedBox(
              height: 16 * sizeUnit,
              child: const VerticalDivider(color: Colors.black),
            ),
            Gap($style.insets.$4),
            Text(
              DateFormat('MM.dd').format(controller.now),
              style: $style.text.headline28.copyWith(height: 1.15),
            ),
            Gap($style.insets.$4),
            Text(
              DateFormat('EEEE').format(controller.now).toUpperCase(),
              style: $style.text.headline12.copyWith(height: 1.15),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
