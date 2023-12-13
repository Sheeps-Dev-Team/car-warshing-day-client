import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/screens/login/login_page.dart';
import 'package:car_washing_day/screens/profile/controllers/profile_controller.dart';
import 'package:car_washing_day/screens/profile/profile_detail_page.dart';
import 'package:car_washing_day/util/components/base_widget.dart';
import 'package:car_washing_day/util/components/custom_data_table.dart';
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: $style.insets.$16),
          child: Column(
            children: [
              Gap($style.insets.$32),
              if (isLogin) ...{
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '로그인 해주세요',
                      style: $style.text.headline20,
                    ),
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
                  ],
                ),
              } else if (!isLogin) ...{
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(style: $style.text.headline20, children: [
                        const TextSpan(
                          text: '어서오세요\n',
                        ),
                        TextSpan(
                          text: 'OOO',
                          style: $style.text.headline20
                              .copyWith(color: $style.colors.primary),
                        ),
                        const TextSpan(
                          text: '님',
                        ),
                      ]),
                    ),
                    InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: 96 * sizeUnit,
                        height: 32 * sizeUnit,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: $style.colors.primary),
                          borderRadius: BorderRadius.circular(52 * sizeUnit),
                        ),
                        child: Text(
                          '프로필 수정 ',
                          style: $style.text.headline14
                              .copyWith(color: $style.colors.primary),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        Get.to(() => const ProfileDetailPage());
                      },
                    ),
                  ],
                ),
              },
              Gap(32 * sizeUnit),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: GetBuilder<ProfileController>(builder: (controller) {
                    return CustomDataTable(
                      columns: controller.dataTableColumns,
                      rows: List.generate(
                          isLogin ? 0 : 100,
                          (index) => [
                                '03.03',
                                '03.03 - 03.07',
                                '5일',
                              ]),
                      onRowTap: (index) {},
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
