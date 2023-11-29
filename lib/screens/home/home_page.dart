import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/data/models/weather.dart';
import 'package:car_washing_day/util/components/custom_app_bar.dart';
import 'package:car_washing_day/util/components/rain/rain.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        leading: SizedBox.shrink(),
        title: '세차언제',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: $style.insets.$16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 300 * sizeUnit,
              child: const Rain(rainingType: RainingType.snow),
            ),
          ],
        ),
      ),
    );
  }
}
