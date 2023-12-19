import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/screens/profile/controllers/profile_controller.dart';
import 'package:car_washing_day/util/components/base_widget.dart';
import 'package:car_washing_day/util/components/custom_app_bar.dart';
import 'package:car_washing_day/util/components/custom_dropdown_button.dart';
import 'package:car_washing_day/util/components/custom_switch_button.dart';
import 'package:car_washing_day/util/components/custom_text_field.dart';
import 'package:car_washing_day/util/global_function.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProfileDetailPage extends StatelessWidget {
  ProfileDetailPage({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Scaffold(
        appBar: CustomAppBar(
          title: '프로필 수정',
          leading: const SizedBox.shrink(),
          actions: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.close,
                size: 24 * sizeUnit,
              ),
            )
          ],
        ),
        body: GestureDetector(
          onTap: GlobalFunction.unFocus,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: $style.insets.$16),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Gap($style.insets.$24),
                        Text(
                          '닉네임',
                          style: $style.text.headline16,
                        ),
                        Gap($style.insets.$16),
                        CustomTextField(
                          hintText: '입력해 주세요.',
                          hintStyle: $style.text.subTitle14
                              .copyWith(color: $style.colors.grey),
                          textAlign: TextAlign.center,
                          width: 328 * sizeUnit,
                          borderRadius: BorderRadius.circular(100 * sizeUnit),
                          borderColor: $style.colors.lightGrey,
                        ),
                        Gap($style.insets.$24),
                        Text(
                          '위치',
                          style: $style.text.headline16,
                        ),
                        Gap($style.insets.$16),
                        SizedBox(
                          width: 328 * sizeUnit,
                          child: Obx(
                            () => CustomDropdownButton(
                              border:
                                  Border.all(color: $style.colors.lightGrey),
                              value: controller.selectedArea.isEmpty
                                  ? null
                                  : controller.selectedArea.value,
                              items: ['시, 도 선택', '서울', '인천'],
                              hintText: '시, 도 선택',
                              onChanged: (value) {
                                controller.selectedSubArea('');

                                if (value == '시, 도 선택') {
                                  controller.selectedArea('');
                                } else {
                                  controller.selectedArea(value);
                                }
                              },
                            ),
                          ),
                        ),
                        Gap($style.insets.$12),
                        SizedBox(
                          width: 328 * sizeUnit,
                          child: Obx(
                            () => CustomDropdownButton(
                              border:
                                  Border.all(color: $style.colors.lightGrey),
                              value: controller.selectedSubArea.isEmpty
                                  ? null
                                  : controller.selectedSubArea.value,
                              items: ['구,군 선택', '연수구', '남동구'],
                              hintText: '구,군 선택',
                              onChanged: (value) {
                                controller.selectedSubArea('');

                                if (value == '시, 도 선택') {
                                  controller.selectedSubArea('');
                                } else {
                                  controller.selectedSubArea(value);
                                }
                              },
                            ),
                          ),
                        ),
                        Gap($style.insets.$24),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '세차 추천일, 세차 예정일과 같은 유용한 알림을 받아보세요.',
                            style: $style.text.subTitle12
                                .copyWith(color: $style.colors.grey),
                          ),
                        ),
                        Gap($style.insets.$8),
                        Row(
                          children: [
                            Text(
                              'PUSH ALARM',
                              style: $style.text.subTitle16,
                            ),
                            Gap(119 * sizeUnit),
                            CustomSwitchButton(
                              values: const ['ON', 'OFF'],
                              onToggleCallback: (index) {},
                            ),
                          ],
                        ),
                        Gap(41 * sizeUnit),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              '회원탈퇴',
                              style: $style.text.subTitle12
                                  .copyWith(color: $style.colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    width: 328 * sizeUnit,
                    height: 44 * sizeUnit,
                    decoration: BoxDecoration(
                      color: $style.colors.primary,
                      borderRadius: BorderRadius.circular(52 * sizeUnit),
                    ),
                    child: Text(
                      '수정 완료',
                      style:
                          $style.text.headline16.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
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
