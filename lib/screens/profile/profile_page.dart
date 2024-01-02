import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/data/region_data.dart';
import 'package:car_washing_day/screens/login/login_page.dart';
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

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    bool isLogin = false;

    return BaseWidget(
      child: Scaffold(
        appBar: CustomAppBar(
          centerTitle: true,
          title: isLogin ? '로그인 해주세요' : '',
          titleWidget: isLogin
              ? null
              : RichText(
                  text: TextSpan(
                      style: $style.text.headline20.copyWith(
                          color: $style.colors.primary,
                          fontWeight: FontWeight.w700),
                      children: [
                        TextSpan(
                          text: '어서오세요! ',
                          style: $style.text.headline20
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        const TextSpan(
                          text: 'OOO',
                        ),
                        TextSpan(
                          text: '님',
                          style: $style.text.headline20
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ]),
                ),
          leading: const SizedBox.shrink(),
          actions: [
            isLogin
                ? const SizedBox.shrink()
                : Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Text(
                          '수정하기',
                          style: $style.text.headline14
                              .copyWith(color: $style.colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Gap($style.insets.$16),
                    ],
                  )
          ],
        ),
        body: GestureDetector(
          onTap: GlobalFunction.unFocus,
          child: Padding(
            padding: isLogin
                ? EdgeInsets.symmetric(horizontal: 104 * sizeUnit)
                : EdgeInsets.symmetric(horizontal: $style.insets.$16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment:
                  isLogin ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                if (isLogin) ...{
                  InkWell(
                    onTap: () {
                      Get.to(() => const LoginPage());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 80 * sizeUnit,
                      height: 32 * sizeUnit,
                      decoration: BoxDecoration(
                        color: $style.colors.primary,
                        borderRadius: BorderRadius.circular(52 * sizeUnit),
                      ),
                      child: Text(
                        '로그인 하기',
                        style: $style.text.headline14
                            .copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Gap($style.insets.$12),
                  Text(
                    '로그인 후 이용이 가능합니다:)',
                    style: $style.text.subTitle12
                        .copyWith(color: $style.colors.grey),
                  ),
                } else if (!isLogin) ...{
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
                                items: ['시, 도 선택', ...areaMap.keys],
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
                                items: controller.selectedArea.isEmpty
                                    ? []
                                    : [
                                        '구, 군 선택',
                                        ...areaMap[
                                            controller.selectedArea.value]!
                                      ],
                                hintText: '구,군 선택',
                                onChanged: (value) {
                                  if (value == '구, 군 선택') {
                                    controller.selectedSubArea('');
                                  } else {
                                    controller.selectedSubArea(value);
                                  }
                                },
                              ),
                            ),
                          ),
                          Gap($style.insets.$24),
                          Text(
                            '강수 확률 선택',
                            style: $style.text.headline16,
                          ),
                          Gap($style.insets.$16),
                          SizedBox(
                            width: 328 * sizeUnit,
                            child: Obx(
                              () => CustomDropdownButton(
                                border:
                                    Border.all(color: $style.colors.lightGrey),
                                value: controller
                                        .selectedPrecipitationProbability
                                        .isEmpty
                                    ? null
                                    : controller
                                        .selectedPrecipitationProbability.value,
                                items: [
                                  '강수 확률 선택',
                                  '10%',
                                  '20%',
                                  '30%',
                                  '40%',
                                  '50%',
                                  '60%',
                                  '70%',
                                  '80%',
                                  '90%',
                                  '100%'
                                ],
                                hintText: '강수 확률 선택',
                                onChanged: (value) {
                                  if (value == '강수 확률 선택') {
                                    controller
                                        .selectedPrecipitationProbability('');
                                  } else {
                                    controller.selectedPrecipitationProbability(
                                        value);
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
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        '회원탈퇴',
                        style: $style.text.subTitle12
                            .copyWith(color: $style.colors.grey),
                      ),
                    ),
                  ),
                  if (MediaQuery.of(context).padding.bottom == 0) ...[
                    Gap($style.insets.$20),
                  ],
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}
