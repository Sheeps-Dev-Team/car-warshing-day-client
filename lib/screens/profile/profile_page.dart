import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/screens/profile/controllers/profile_controller.dart';
import 'package:car_washing_day/util/components/base_widget.dart';
import 'package:car_washing_day/util/components/custom_data_table.dart';
import 'package:car_washing_day/util/components/custom_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  //final ProfileController controller = Get.put(ProfileController());

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final ProfileController controller = Get.put(ProfileController());

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    bool isLogin = false;
    List<String> testList = [
      '1',
      '2',
      '3',
    ];

    return BaseWidget(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: $style.insets.$16),
          child: Column(
            children: [
              Gap($style.insets.$32),
              if (isLogin == true) ...{
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '로그인 해주세요',
                      style: $style.text.headline20,
                    ),
                    InkWell(
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
                    Column(
                      children: [
                        Text(
                          'PUSH ALARM',
                          style: $style.text.subTitle12,
                        ),
                        Gap(6 * sizeUnit),
                        CustomSwitchButton(
                          values: const ['ON', 'OFF'],
                          onToggleCallback: (value) {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              },
              Gap(47 * sizeUnit),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: GetBuilder<ProfileController>(builder: (_) {
                  return CustomDataTable(
                    columns: controller.dataTableColumns,
                    // rows: List.generate(
                    //   1,
                    //   (index) => [
                    //     (index + 1).toString(),
                    //   ],
                    // ),
                    rows: List.generate(1, (index) => testList),
                    onRowTap: (index) {},
                  );
                }),
              ),
              InkWell(
                child: Text(
                  '회원 탈퇴',
                  style: $style.text.subTitle12
                      .copyWith(color: $style.colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
