import 'package:car_washing_day/data/models/weather.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/rain_controller.dart';
import 'one_drop.dart';

class Rain extends StatelessWidget {
  const Rain({Key? key, required this.rainingType}) : super(key: key);

  final RainingType rainingType;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return GetBuilder<RainController>(
          init: Get.put(RainController()),
          builder: (controller) {
            return Stack(
              children: controller.rainDropId
                  .map((e) => OneDrop(
                        id: e,
                        screen: constrains.biggest,
                        rainingType: rainingType,
                      ))
                  .toList(),
            );
          },
        );
      },
    );
  }
}
