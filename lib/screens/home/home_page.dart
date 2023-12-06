import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/screens/home/controllers/home_controller.dart';
import 'package:car_washing_day/util/components/bubble/bubble.dart';
import 'package:car_washing_day/util/components/car_animation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/models/weather.dart';
import '../../util/components/bubble/bubble_lump.dart';
import '../../util/components/rain/rain.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
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
              child: const Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Bubble(),
                    BubbleLump(),
                    CarAnimation(),
                    Rain(rainingType: RainingType.rainAndSnow),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Text('인천 광역시 연수구', style: $style.text.subTitle12),
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
