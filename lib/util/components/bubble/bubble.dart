import 'package:car_washing_day/util/components/bubble/controllers/bubble_controller.dart';
import 'package:car_washing_day/util/components/bubble/oneBubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bubble extends StatelessWidget {
  const Bubble({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return GetBuilder<BubbleController>(
          init: Get.put(BubbleController()),
          builder: (controller) {
            return Stack(
              children: List.generate(
                controller.bubbleId.length,
                (index) => OneBubble(
                  id: controller.bubbleId[index],
                  screen: constrains.biggest,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
