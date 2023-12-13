import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/config/global_assets.dart';
import 'package:car_washing_day/screens/login/login_detail_page.dart';
import 'package:car_washing_day/util/components/base_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: $style.insets.$16),
            child: Column(
              children: [
                const Spacer(flex: 2),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: $style.text.headline48.copyWith(
                          color: $style.colors.primary,
                          fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text: '세차 ',
                          style: $style.text.headline48
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const TextSpan(
                          text: '언제?',
                        ),
                      ]),
                ),
                const Spacer(flex: 2),
                GestureDetector(
                  child: SvgPicture.asset(
                    GlobalAssets.svgKakaoLogin,
                    height: 48 * sizeUnit,
                  ),
                  onTap: () {
                    Get.to(() => LoginDetailPage());
                  },
                ),
                Gap($style.insets.$15),
                GestureDetector(
                  child: SvgPicture.asset(
                    GlobalAssets.svgAppleLogin,
                    height: 48 * sizeUnit,
                  ),
                  onTap: () {},
                ),
                Gap($style.insets.$15),
                GestureDetector(
                  child: SvgPicture.asset(
                    GlobalAssets.svgGoogleLogin,
                    height: 48 * sizeUnit,
                  ),
                  onTap: () {},
                ),
                const Spacer(),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: $style.text.body12
                          .copyWith(color: $style.colors.grey),
                      children: [
                        const TextSpan(
                          text: '로그인 이전에 sheeps의\n',
                        ),
                        underlineTextWidget(text: '서비스 이용약관', onTap: () {}),
                        const TextSpan(
                          text: '과 ',
                        ),
                        underlineTextWidget(text: '개인정보 처리방침', onTap: () {}),
                        const TextSpan(
                          text: '을\n읽고 이해했으며 이에 동의합니다.',
                        ),
                      ]),
                ),
                const Spacer(),
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

  //서비스 이용약관, 개인정보 처리방침 위젯
  TextSpan underlineTextWidget(
      {required String text, required GestureTapCallback onTap}) {
    return TextSpan(
      text: text,
      style: $style.text.subTitle12.copyWith(
          color: $style.colors.primary,
          decoration: TextDecoration.underline,
          decorationColor: $style.colors.primary),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }
}
