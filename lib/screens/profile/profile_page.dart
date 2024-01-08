import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/config/global_assets.dart';
import 'package:car_washing_day/data/global_data.dart';
import 'package:car_washing_day/data/region_data.dart';
import 'package:car_washing_day/screens/login/login_page.dart';
import 'package:car_washing_day/screens/profile/controllers/profile_controller.dart';
import 'package:car_washing_day/util/components/base_widget.dart';
import 'package:car_washing_day/util/components/custom_app_bar.dart';
import 'package:car_washing_day/util/components/custom_button.dart';
import 'package:car_washing_day/util/components/custom_dropdown_button.dart';
import 'package:car_washing_day/util/components/custom_switch_button.dart';
import 'package:car_washing_day/util/components/custom_text_field.dart';
import 'package:car_washing_day/util/global_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({
    super.key,
    required this.isEditMode,
  });

  final bool isEditMode; //회원가입 후 상태

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Scaffold(
        appBar: CustomAppBar(
          centerTitle: true,
          titleWidget: isEditMode
              ? GlobalData.loginUser == null
                  ? Text('로그인 해주세요', style: $style.text.headline20)
                  : RichText(
                      text: TextSpan(
                        style: $style.text.headline20.copyWith(color: $style.colors.primary, fontWeight: FontWeight.w700),
                        children: [
                          TextSpan(
                            text: '어서오세요! ',
                            style: $style.text.headline20.copyWith(fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: GlobalData.loginUser!.nickName,
                          ),
                          TextSpan(
                            text: '님',
                            style: $style.text.headline20.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    )
              : Text('필수 정보 입력', style: $style.text.headline20),
          leading: const SizedBox.shrink(),
          actions: isEditMode
              ? GlobalData.loginUser != null
                  ? [
                      InkWell(
                          onTap: () {
                            if (controller.isOk.value) controller.updateUser();
                          },
                          child: Obx(
                            () => Text(
                              '수정하기',
                              style: $style.text.headline14.copyWith(color: controller.isOk.value ? $style.colors.primary : $style.colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      Gap($style.insets.$16),
                    ]
                  : null
              : [
                  InkWell(
                    onTap: () => Get.offAll(() => LoginPage()),
                    child: SvgPicture.asset(
                      GlobalAssets.svgCancel,
                      width: 24 * sizeUnit,
                    ),
                  ),
                  Gap($style.insets.$16),
                ],
        ),
        body: GetBuilder<ProfileController>(
            initState: (state) => controller.init(isEditMode),
            builder: (_) {
              return GestureDetector(
                onTap: GlobalFunction.unFocus,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: $style.insets.$16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: GlobalData.loginUser != null ? MainAxisAlignment.start : MainAxisAlignment.center,
                    children: [
                      if (isEditMode && GlobalData.loginUser == null) ...{
                        Center(
                          child: InkWell(
                            onTap: () {
                              Get.to(() => LoginPage());
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
                                style: $style.text.headline14.copyWith(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Gap($style.insets.$12),
                        Text(
                          '로그인 후 이용이 가능합니다:)',
                          style: $style.text.subTitle12.copyWith(color: $style.colors.darkGrey),
                        ),
                      } else ...{
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
                                  hintStyle: $style.text.subTitle14.copyWith(color: $style.colors.grey),
                                  controller: controller.nicknameController,
                                  style: $style.text.subTitle14,
                                  textAlign: TextAlign.center,
                                  width: 328 * sizeUnit,
                                  borderRadius: BorderRadius.circular(100 * sizeUnit),
                                  borderColor: $style.colors.lightGrey,
                                  maxLength: 7,
                                  counterText: '',
                                  onChanged: (p0) => controller.nickname(p0),
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
                                      border: Border.all(color: $style.colors.lightGrey),
                                      value: controller.selectedArea.isEmpty ? null : controller.selectedArea.value,
                                      items: areaMap.keys.toList(),
                                      hintText: '시, 도 선택',
                                      onChanged: (value) {
                                        controller.selectedSubArea('');

                                        controller.selectedArea(value);
                                      },
                                    ),
                                  ),
                                ),
                                Gap($style.insets.$12),
                                SizedBox(
                                  width: 328 * sizeUnit,
                                  child: Obx(
                                    () => CustomDropdownButton(
                                      border: Border.all(color: $style.colors.lightGrey),
                                      value: controller.selectedSubArea.isEmpty ? null : controller.selectedSubArea.value,
                                      items: controller.selectedArea.isEmpty ? [] : areaMap[controller.selectedArea.value]!,
                                      hintText: '구,군 선택',
                                      onChanged: (value) {
                                        controller.selectedSubArea(value);
                                      },
                                    ),
                                  ),
                                ),
                                Gap($style.insets.$24),
                                Text(
                                  '강수 확률 설정',
                                  style: $style.text.headline16,
                                ),
                                Gap($style.insets.$14),
                                Text(
                                  '설정된 강수 확률 이하는 세차 지속일에 영향을 주지 않습니다.',
                                  style: $style.text.subTitle12.copyWith(color: $style.colors.darkGrey),
                                ),
                                Gap($style.insets.$16),
                                SizedBox(
                                  width: 328 * sizeUnit,
                                  child: Obx(
                                    () => CustomDropdownButton(
                                      border: Border.all(color: $style.colors.lightGrey),
                                      value: controller.selectedPrecipitationProbability.isEmpty ? null : controller.selectedPrecipitationProbability.value,
                                      items: const ['0%', '10%', '20%', '30%', '40%', '50%', '60%', '70%', '80%', '90%', '100%'],
                                      hintText: '강수 확률 선택',
                                      onChanged: (value) {
                                        if (value == '강수 확률 선택') {
                                          controller.selectedPrecipitationProbability('');
                                        } else {
                                          controller.selectedPrecipitationProbability(value);
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
                                    style: $style.text.subTitle12.copyWith(color: $style.colors.darkGrey),
                                  ),
                                ),
                                Gap($style.insets.$8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '알림 설정',
                                      style: $style.text.headline16,
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
                        if (isEditMode) ...{
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: controller.deleteUser,
                              child: Text(
                                '회원탈퇴',
                                style: $style.text.subTitle12.copyWith(color: $style.colors.grey),
                              ),
                            ),
                          ),
                        } else ...{
                          Obx(() => CustomButton(
                                text: '입력 완료',
                                isOk: controller.isOk.value,
                                onTap: controller.createUser,
                              )),
                        },
                        if (MediaQuery.of(context).padding.bottom == 0) ...[
                          Gap($style.insets.$20),
                        ],
                      },
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
