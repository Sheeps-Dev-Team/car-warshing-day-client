import 'package:car_washing_day/data/models/weather.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/rain_controller.dart';
import 'one_drop.dart';

class Rain extends StatelessWidget {
  Rain({super.key, required this.rainingType});

  final RainingType rainingType;

  final RainController controller = Get.put(RainController());

  @override
  Widget build(BuildContext context) {
    if(rainingType == RainingType.none) return const SizedBox();

    return LayoutBuilder(
      builder: (context, constrains) {
        return GetBuilder<RainController>(
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
