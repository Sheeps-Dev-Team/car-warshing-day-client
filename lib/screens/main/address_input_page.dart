import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/config/global_assets.dart';
import 'package:car_washing_day/screens/main/controllers/address_input_controller.dart';
import 'package:car_washing_day/util/components/base_widget.dart';
import 'package:car_washing_day/util/components/custom_app_bar.dart';
import 'package:car_washing_day/util/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../data/region_data.dart';
import '../../util/components/custom_dropdown_button.dart';

class AddressInputPage extends StatelessWidget {
  AddressInputPage({super.key});

  final AddressInputController controller = Get.put(AddressInputController());

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Scaffold(
        appBar: CustomAppBar(
          leading: const SizedBox.shrink(),
          title: '위치 정보 입력',
          actions: [
            InkWell(
              onTap: Get.back,
              child: SvgPicture.asset(GlobalAssets.svgCancel, width: 24 * sizeUnit),
            ),
            Gap($style.insets.$16),
          ],
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: $style.insets.$16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text('위치', style: $style.text.headline16),
                Gap($style.insets.$16),
                Obx(
                  () => CustomDropdownButton(
                    border: Border.all(color: $style.colors.lightGrey),
                    value: controller.selectedArea.isEmpty ? null : controller.selectedArea.value,
                    items: areaMap.keys.toList(),
                    hintText: '시, 도 선택',
                    onChanged: controller.onChangedArea,
                  ),
                ),
                Gap($style.insets.$12),
                Obx(
                  () => CustomDropdownButton(
                    border: Border.all(color: $style.colors.lightGrey),
                    value: controller.selectedSubArea.isEmpty ? null : controller.selectedSubArea.value,
                    items: controller.selectedArea.isEmpty ? [] : areaMap[controller.selectedArea.value]!,
                    hintText: '구,군 선택',
                    onChanged: controller.onChangedSubArea,
                  ),
                ),
                Gap($style.insets.$16),
                Text(
                  '위치 변경은 로그인 후 가능합니다.',
                  style: $style.text.subTitle12.copyWith(
                    color: $style.colors.darkGrey,
                  ),
                ),
                const Spacer(),
                Obx(() => CustomButton(
                      text: '입력 완료',
                      isOk: controller.isOk.value,
                      onTap: controller.setAddress,
                    )),
                if (MediaQuery.of(context).padding.bottom == 0) ...[
                  Gap($style.insets.$20),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
